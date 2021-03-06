<html>
	<head>
		<!DOCTYPE html>
		<script src="{{base_url}}static/jquery/jquery-latest.min.js"></script>
		<script src="{{base_url}}static/semantic/semantic.min.js"></script>
		<script src="{{base_url}}static/jquery/tablesort.js"></script>
		<link rel="stylesheet" href="{{base_url}}static/semantic/semantic.min.css">
		
		<link rel="apple-touch-icon" sizes="120x120" href="{{base_url}}static/apple-touch-icon.png">
		<link rel="icon" type="image/png" sizes="32x32" href="{{base_url}}static/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="16x16" href="{{base_url}}static/favicon-16x16.png">
		<link rel="manifest" href="{{base_url}}static/manifest.json">
		<link rel="mask-icon" href="{{base_url}}static/safari-pinned-tab.svg" color="#5bbad5">
		<link rel="shortcut icon" href="{{base_url}}static/favicon.ico">
		<meta name="msapplication-config" content="{{base_url}}static/browserconfig.xml">
		<meta name="theme-color" content="#ffffff">
		
		<title>History - Bazarr</title>
		
		<style>
			body {
				background-color: #272727;
			}
			#fondblanc {
				background-color: #ffffff;
				border-radius: 0px;
				box-shadow: 0px 0px 5px 5px #ffffff;
				margin-top: 32px;
				margin-bottom: 3em;
				padding: 3em;
			}
			.fast.backward, .backward, .forward, .fast.forward {
    			cursor: pointer;
			}
			.fast.backward, .backward, .forward, .fast.forward { pointer-events: auto; }
			.fast.backward.disabled, .backward.disabled, .forward.disabled, .fast.forward.disabled { pointer-events: none; }
		</style>
	</head>
	<body>
		<div id='loader' class="ui page dimmer">
		   	<div class="ui indeterminate text loader">Loading...</div>
		</div>
		% include('menu.tpl')
			
		<div id="fondblanc" class="ui container">
			<table id="tablehistory" class="ui very basic selectable table">
				<thead>
					<tr>
						<th></th>
						<th>Series</th>
						<th>Episode</th>
						<th>Episode Title</th>
						<th>Date</th>
						<th>Description</th>
					</tr>
				</thead>
				<tbody>
				%import time
				%import pretty
				%for row in rows:
					<tr class="selectable">
						<td class="collapsing">
						%if row[0] == 0:
							<div class="ui inverted basic compact icon" data-tooltip="Subtitles file have been erased." data-inverted="">
								<i class="ui trash icon"></i>
							</div>
						%elif row[0] == 1:
							<div class="ui inverted basic compact icon" data-tooltip="Subtitles file have been downloaded." data-inverted="">
								<i class="ui download icon"></i>
							</div>
						%end
						</td>
						<td><a href="{{base_url}}episodes/{{row[6]}}">{{row[1]}}</a></td>
						<td class="collapsing">
							<%episode = row[2].split('x')%>
							{{episode[0] + 'x' + episode[1].zfill(2)}}
						</td>
						<td>{{row[3]}}</td>
						<td class="collapsing">
							<div class="ui inverted" data-tooltip="{{time.strftime('%A, %B %d %Y %H:%M', time.localtime(row[4]))}}" data-inverted="">
								{{pretty.date(int(row[4]))}}
							</div>
						</td>
						<td>{{row[5]}}</td>
					</tr>
				%end
				</tbody>
			</table>
			<div class="ui grid">
				<div class="three column row">
			    	<div class="column"></div>
			    	<div class="center aligned column">
			    		<i class="\\
			    		%if page == '1':
			    		disabled\\
			    		%end
			    		 fast backward icon"></i>
			    		<i class="\\
			    		%if page == '1':
			    		disabled\\
			    		%end
			    		 backward icon"></i>
			    		{{page}} / {{max_page}}
			    		<i class="\\
			    		%if int(page) == int(max_page):
			    		disabled\\
			    		%end
			    		 forward icon"></i>
			    		<i class="\\
			    		%if int(page) == int(max_page):
			    		disabled\\
			    		%end
			    		 fast forward icon"></i>
			    	</div>
			    	<div class="right floated right aligned column">Total records: {{row_count}}</div>
				</div>
			</div>
		</div>
		% include('footer.tpl')
	</body>
</html>


<script>
	if (sessionStorage.scrolly) {
	    $(window).scrollTop(sessionStorage.scrolly);
	    sessionStorage.clear();
	}

	$('a, i').click(function(){
		sessionStorage.scrolly=$(window).scrollTop();

		$('#loader').addClass('active');
	})

	$('.backward').click(function(){
		location.href="?page={{int(page)-1}}";
	})
	$('.fast.backward').click(function(){
		location.href="?page=1";
	})
	$('.forward').click(function(){
		location.href="?page={{int(page)+1}}";
	})
	$('.fast.forward').click(function(){
		location.href="?page={{int(max_page)}}";
	})
</script>