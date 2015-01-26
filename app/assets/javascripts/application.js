$(document).ready(function() {
	var form = $('#mainForm');
	var pageName = $('body').attr('page-name');
	$('.datepicker').datepicker({format: 'yyyy-mm-dd', startDate: '2000-01-01'})

	function centerModal() {
		var doc = document.documentElement, body = document.body;
		var left = (doc && doc.scrollLeft || body && body.scrollLeft || 0);
		var top = (doc && doc.scrollTop  || body && body.scrollTop  || 0);
	    $(this).css('display', 'block');
	    var $dialog = $(this).find(".modal-dialog");
	    var offset = (($(window).height() - $dialog.height()) / 2);
	    // Center modal vertically in window
	    $dialog.css("margin-top", offset);
	}

	$('.modal').on('show.bs.modal', centerModal);
	$(window).on("resize", function () {
	    $('.modal:visible').each(centerModal);
	});

	if (pageName == 'tableIndexDetails'){
		if ($('input[name="index-name[]"]:checked').length == 0)
			$('#rebuild-selected-indexes').addClass('disabled');
		else
			$('#rebuild-selected-indexes').removeClass('disabled');
	}
	$('#site-menu ul.navbar-nav > li').hover(
		function(){
			$(this).find('a > .caret').css('visibility','visible');
		},
		function(){
			$(this).find('a > .caret').css('visibility','hidden');
		});
	
	$('.pagination > li > a').on('click',function(e){
		e.preventDefault();
		if ($(this).parent().hasClass('active') || $(this).parent().hasClass('pagination-arrow') )
			return
		var pageClicked = $(this).text();
		var input = $("<input>").attr("type", "hidden").attr("name","pageNumber").val(pageClicked);
		form.append($(input)).submit();
	});
	$('.pagination > li.pagination-arrow > a').on('click',function(e){
		e.preventDefault();
		if ($(this).parent().hasClass('disabled'))
			return
		var minpage = $(this).parents('.pagination').attr('data-min-page');
		var maxpage = $(this).parents('.pagination').attr('data-max-page');
		var isFirst = $(this).parent().hasClass('left');
		var isNext = $(this).parent().hasClass('next');
		var isPrev = $(this).parent().hasClass('prev');
		var isPrevNext = [isNext || isPrev, isPrev, isNext];
		var activePage = parseInt($(this).parents('.pagination').find('li.active').text(),10);
		var input;
		//console.log (isPrevNext)
		if (isPrevNext[0] == true) {
				if (isPrevNext[1] == true && isPrevNext[2] == false)
					input = $("<input>").attr("type", "hidden").attr("name","pageNumber").val(activePage-1);
				else if (isPrevNext[1] == false && isPrevNext[2] == true)
					input = $("<input>").attr("type", "hidden").attr("name","pageNumber").val(activePage+1);
		}
		else {
			//console.log(isFirst == true ? minpage : maxpage)
			input = $("<input>").attr("type", "hidden").attr("name","pageNumber").val(isFirst == true ? minpage : maxpage);
			
		}
		form.append($(input)).submit();
	});
	$(document).on('click','input[name="index-name[]"]', function(){
		if ($('input[name="index-name[]"]:checked').length == 0)
			$('#rebuild-selected-indexes').addClass('disabled');
		else
			$('#rebuild-selected-indexes').removeClass('disabled');
	})
	$(document).on('change','#index-name-all', function(){
		//console.log($(this).is(':checked'))
		if (!$(this).is(':checked')){
			$('input[name="index-name[]"]').prop('checked',false);
			$('#rebuild-selected-indexes').addClass('disabled');
		}			
		else {
			$('input[name="index-name[]"]').prop('checked',true);
			$('#rebuild-selected-indexes').removeClass('disabled');
		}
	})
	$('#rebuild-selected-indexes').on('click',function(e){
		e.preventDefault();
		var indexes = new Array();
		var append = "";
		$('input[name="index-name[]"]:checked').each(function() {
			indexes.push([$(this).attr('data-guid'),$(this).attr('value')]);
			var elemtr = document.createElement('tr')
			elemtr = $(elemtr)
			elemtr.append('<td/>')
			var elem = document.createElement('div')
			elem.setAttribute('id',$(this).attr('data-guid'))
			elem.setAttribute('style','overflow: hidden')
			elem.setAttribute('style','cursor: default')
			elem = $(elem)
			elem.append("<div style='width: 20px;float:left; margin-bottom:5px; position:relative;'><span style='visibility:hidden; float:left; position:absolute;top: 5px;' class='glyphicon glyphicon-ok-circle green'></span><span style='visibility:hidden; float:left; position:absolute; top:5px' class='glyphicon glyphicon-ban-circle red'></span></div><div style='float:left; width:535px;'>"+$(this).attr('value')+"</div>")
			elemtr.children().eq(0).append(elem)
			$('#rebuild-index-modal .modal-body > .indexes-list').append(elemtr)
		});
			$('#rebuild-index-modal .modal-body').append("<div id='please-wait' class='progress progress-striped active' style='height:15px; margin-top: 10px; margin-bottom: 0;'><div class='progress-bar'  role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'></div></div>");

		if (indexes.length == 0)
			return
				$('#rebuild-index-modal').modal('show');
		jQuery.each(indexes,function(index, item){
			var prop = item[1].split('.');
			var data = {
				database : prop[0],
				schema : prop[1],
				table : prop[2],
				index : prop[3],
				guid : item[0]
			}
			$.ajax({
			  url: "/rebuildIndex",
			  data: data,
			  type: "POST",
			  dataType: "html",
			  async: false
			}).done(function( data ) {
			    var htmlresponse = $('<div/>').html(data);
			    htmlresponse = htmlresponse.find('#request-response');
			    var guid = htmlresponse.attr('data-guid');
			  
			    if(htmlresponse.attr('data-response') == 'SUCCESS'){
			    	$('#'+guid).find('.glyphicon-ok-circle').css('visibility','visible');
			    }else{
			    	$('#'+guid).find('.glyphicon-ban-circle').css('visibility','visible');
			    	$('#'+guid).append("<div class='error' style='font-size: 12px; color: red;'>"+htmlresponse.attr('data-response')+"</div>")
			    }
			  });
		})
		$('#please-wait').remove();
		$('.close-rebuild-index-modal').removeClass('disabled');
		$('#rebuild-selected-indexes').addClass('disabled');
	});
	$('#rebuild-index-modal .close-rebuild-index-modal').on('click',function(e){
		//console.log(location.search)
		//var dbId = location.search == 'undefined' || location.search == undefined || location.search.length == 0 ? -1 : location.search.split('databaseId=')[1]
		//dbId = dbId == -1 ? -1 : dbId.split('&')[0]
		//console.log ('dbId: '+dbId)
		$.ajax({
			url: "/getIndexTable",
			data: {},
			type: "POST",
			dataType: "html",
			beforeSend: function(){
				$('#index-details').remove();
				$('div.pagination-wrapper').remove();
				$('#rebuild-index-modal .modal-body > .indexes-list').empty();
				$('#page-wrapper').append("<div id='please-wait' class='progress progress-striped active' style='height:50px; '><div class='progress-bar'  role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%''><span style='font-family: \"Open Sans\",Calibri,Candara,Arial,sans-serif; line-height: 50px; font-size: 28px;'>Please wait...</span></div></div>");
				$('#databaseId').val(-1)
			}
		}).done(function(data){

			$('#please-wait').remove()
			$('#page-wrapper').append(data);
			
			/*$('input[type="checkbox"].large').checkbox({
			    buttonStyle: 'btn-link btn-large',
			    checkedClass: 'icon-check',
			    uncheckedClass: 'icon-check-empty'
			});*/
		});
		//window.location.reload();
	});
	$('#dir-tree').treetable({ expandable: true,
		indenterTemplate : '<span class="indenter" style="padding-left: 0px;"><a href="#" title="Expand">&nbsp;</a></span>'
	 });

	$("#dir-tree tbody").on("mousedown", "tr", function() {
	  $(".selected").not(this).removeClass("selected");
	  $(this).toggleClass("selected");
	});

	$("#dir-tree tbody").on("click", "td > .indenter > a", function(e){
		e.preventDefault();
		var row = $(this).parents("tr");
		var drive = $(this).parents('td').data('dir');
		var guid = row.data("ttId");
		var level = row.data("level")

		if($('tr[data-tt-id="'+guid+'"]').data('empty') == 1){
			$('tr[data-tt-id="'+guid+'"]').removeClass('expanded').removeClass('collapsed')
			return
		}

			
		if(!row.hasClass('expanded'))
		{
			
			if($('tr[data-tt-id="'+guid+'"]').data('expanded') == 0)
			{
				getDirTree(drive,guid,level);
				$('tr[data-tt-parent-id="'+guid+' td > .indenter > a"]').bind("click");
			}
			else
				expandFolder(guid);
			row.removeClass('collapsed').addClass('expanded');
		}
		else {
			row.removeClass('expanded').addClass('collapsed');
			collapseFolder(guid)
		}

	});

	jQuery.fn.reverse = function() {
	    return this.pushStack(this.get().reverse(), arguments);
	};

	function getDirTree(directory, guid, level, newFolder){
		$.ajax({
			url: "/getDirTree",
			data: {directory : directory, guid : guid, level : level},
			type: "POST",
			dataType: "html",
			success: function(data){
				var h = $('<div/>').html(data)
				//console.log(h.find('#no-subdirs').length)
				if(h.find('#no-subdirs').length != 0)
				{
					$('tr[data-tt-id="'+guid+'"]').removeClass('expanded').removeClass('collapsed').data("empty",1);
				}else{
					$('#dir-tree tbody').find('tr[data-tt-id="'+guid+'"]').after(data);
				}
				$('tr[data-tt-id="'+guid+'"]').data('expanded','1').addClass('expanded').removeClass('collapsed');
			}
		});
	}
	function isExpanded(guid){
		if($('tr[data-tt-id="'+guid+'"]').hasClass('expanded'))
		{
			return true
		}
		return false
	}
	function wasExpanded(guid){
		if($('tr[data-tt-id="'+guid+'"]').data('expanded') == 1)
		{
			return true
		}
		return false
	}
	function expandFolder(guid){
		$('tr[data-tt-parent-id="'+guid+'"]').show();
		$('tr[data-tt-id="'+guid+'"]').data('expanded','1').addClass('expanded').removeClass('collapsed');
	}
	function collapseFolder(guid){
		$('tr[data-tt-parent-id="'+guid+'"]').hide().addClass('collapsed').removeClass('expanded');
		$('tr[data-tt-parent-id="'+guid+'"]').each(function(){
			collapseFolder($(this).data("ttId"));
		})
		$('tr[data-tt-id="'+guid+'"]').addClass('collapsed').removeClass('expanded');
	}

	$('#backup-databases').on("click", function(e){
		e.preventDefault();
		var databases = new Array();
		var append = "";
		var data = '';
		var dbval = $('#databaseId').val();
		var folder = $('#folderName').val();
		var backupPath = $('#dir-tree tbody tr.selected > td').data('dir');
		if(backupPath == undefined || backupPath == null || backupPath == 'undefined'){
			$('.bak-error-messages').find('span[data-type="destination"]').show();
			$('.bak-error-messages').show()
			return false;
		} else{
			$('.bak-error-messages').find('span[data-type="destination"]').hide();
			$('.bak-error-messages').hide()
		}
		$.ajax({
			url: "/getDatabaseById",
			data: {databaseId : dbval},
			type: "POST",
			dataType: "html",
			async : false,
		}).done(function(data){
				var h = $('<div/>').html(data);
				h.find('span').each(function(){
					var elemtr = document.createElement('tr')
					elemtr = $(elemtr)
					elemtr.append('<td/>')
					var elem = document.createElement('div')
					elem.setAttribute('data-db-id',$(this).attr('data-db-id'))
					elem.setAttribute('style','overflow: hidden;')
					elem.setAttribute('style','cursor: default')
					elem = $(elem)
					databaseName = $(this).data('dbName')
					databaseId = $(this).data('dbId')
					if(databaseName != 'tempdb'){
						databases.push([databaseId, databaseName]);
						elem.append("<div style='width: 20px;float:left; margin-bottom:5px; position:relative;'><span style='visibility:hidden; float:left; position:absolute;top: 4px;' class='glyphicon glyphicon-ok-circle green'></span><span style='visibility:hidden; float:left; position:absolute; top:4px' class='glyphicon glyphicon-ban-circle red'></span></div><div style='float:left; width:535px;'>Backing up <b>"+databaseName+"</b> on "+backupPath+"</div>")
						elemtr.children().eq(0).append(elem)
						$('#backup-database-modal .modal-body > .db-list').append(elemtr)
					}
				})
			});
		$('#backup-database-modal .modal-body').append("<div id='please-wait' class='progress progress-striped active' style='height:15px; margin-top: 10px; margin-bottom: 0;'><div class='progress-bar'  role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'></div></div>");
		$('#backup-database-modal').modal('show');
		jQuery.each(databases,function(index, item){
			var data = {
				databaseId : item[0],
				path : backupPath
			}
			$.ajax({
			  url: "/backupDatabase",
			  data: data,
			  type: "POST",
			  dataType: "html",
			  async : false
			}).done(function( data ) {
			    var htmlresponse = $('<div/>').html(data);
			    htmlresponse = htmlresponse.find('#request-response');
			  
			    if(htmlresponse.attr('data-response') == 'SUCCESS'){
			    	$('#backup-database-modal div[data-db-id="'+item[0]+'"]').find('.glyphicon-ok-circle').css('visibility','visible');
			    	$('#backup-database-modal div[data-db-id="'+item[0]+'"]').children().eq(1).append(' <i style="float:right;">('+htmlresponse.attr('data-duration')+' sec)</i>');
			    }else{
			    	$('#backup-database-modal div[data-db-id="'+item[0]+'"]').find('.glyphicon-ban-circle').css('visibility','visible');
			    	$('#backup-database-modal div[data-db-id="'+item[0]+'"]').children().eq(1).append(' <i style="float:right;">('+htmlresponse.attr('data-duration')+' sec)</i>');
			    	$('#backup-database-modal div[data-db-id="'+item[0]+'"]').append("<div class='error' style='font-size: 12px; color: red;'>"+htmlresponse.attr('data-response')+"</div>")
			    }
			});
		});
		$('#please-wait').remove();
		$('.close-backup-database-modal').removeClass('disabled');
	});
	$('#backup-database-modal .close-backup-database-modal').on('click',function(e){
		window.location.reload();
	});
	$('.sql-popover').popover();
	$('#refresh-processes').on('click', function(e){
		console.log('aaa')
		$.ajax({
			  url: "/getRunningProcessesTable",
			  data: {},
			  type: "POST",
			  dataType: "html",
			  beforeSend: function(){
			  	$('#running-processes').remove();
				$('#page-wrapper').append("<div id='please-wait' class='progress progress-striped active' style='height:50px; '><div class='progress-bar'  role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%''><span style='font-family: \"Open Sans\",Calibri,Candara,Arial,sans-serif; line-height: 50px; font-size: 28px;'>Please wait...</span></div></div>");
			}
		}).done(function(data){
			$('#please-wait').remove()
			$('#page-wrapper').append(data);
			$('.sql-popover').popover();
		});
	});
	/*$('input[type="checkbox"].large').checkbox({
	    buttonStyle: 'btn-link btn-large',
	    checkedClass: 'icon-check',
	    uncheckedClass: 'icon-check-empty'
	});
*/
});