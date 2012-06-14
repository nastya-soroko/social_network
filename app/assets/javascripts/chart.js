function displayStatistics(obj){

        obj = obj.replace(/&(lt|gt|quot);/g, function (m, p) { 
          return (p == "lt")? "<" : (p == "gt") ? ">" : "'";
        });

        obj = obj.substring(1,obj.length-1);

        obj = eval('[' + obj + ']');

        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'chart',
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: 'Statistics of microposts on your wall.'
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.point.name + '</b>: ' + this.percentage + ' %';
                }
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function () {
                            return '<b>' + this.point.name + '</b>: ' + this.percentage + ' %';
                        }
                    }
                }
            },
            series: [{
                type: 'pie',
                name: 'Browser share',
                data: obj[0]                    
            }]
        });
        $("#chart").attr('style','align:center;').dialog({
                    height: 'auto',
                    width: 'auto',
                    modal:true
                });
}    