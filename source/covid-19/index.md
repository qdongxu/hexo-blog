---
title: 新型冠状病毒感染的肺炎
date: 2020-01-27
---

## 病例数量变化

<div>
    <script src="/js/Chart.min.js"></script>
    <div>
        <h3>确诊、疑似</h3>
        <canvas id="myChart-a" width="400" height="240"></canvas>
    </div>
    <br/>
    <div>
        <h3>重症、死亡、治愈</h3>
        <canvas id="myChart-b" width="400" height="240"></canvas>
    </div>
    <br/>
    <div>
        <h3>医学观察</h3>
        <canvas id="myChart-c" width="400" height="240"></canvas>
    </div>
    <br/>
    <script>
    const originData =
    `日期,      疑似,  确诊,  重症,  治愈,  死亡,  接触,   观察;
    20200120,  54,    291,   63,    25,    6,     1739,   922;
    20200121,  37,    440,   102,   25,    9,     2197,   1394;
    20200122,  393,   571,   95,    25,    17,    5897,   4928;
    20200123,  1072,  830,   177,   34,    25,    9507,   8420;
    20200124,  1965,  1287,  237,   38,    41,    15197,  13976;
    20200125,  2684,  1975,  324,   49,    56,    23431,  21556;
    20200126,  5794,  2744,  461,   51,    80,    32799,  30453;
    20200127,  6973,  4515,  976,   60,    106,   47833,  44132;
    20200128,  9239,  5947,  1239,  103,   132,   65537,  59990;
    20200129,  12167, 7711,  1370,  124,   170,   88693,  81947;
    20200130,  15238, 9692,  1527,  171,   213,   113579, 102427;
    20200131,  17988, 11791,  1795, 243,   259,   136987, 118478;
    20200201,  19544, 14380,  2110, 328,   304,   163844, 137594;
    20200202,  21558, 17205,  2296, 475,   361,   189583, 152700;
    20200203,  23214, 20438,  2788, 632,   425,   221015, 171329;
    20200204,  23260, 24324,  3219, 892,   490,   252154, 185555;
    20200205,  24702, 28018,  3859, 1153,  563,   282813, 186354;
    20200206,  26359, 28985,  4821, 1540,  636,   314028, 186045;
    20200207,  27657, 31774,  6101, 2050,  722,   345498, 189660;
    20200208,  28942, 33738,  6188, 2649,  811,   371905, 188183;
    20200209,  23589, 35982,  6489, 3281,  908,   399487, 187157;
    20200210,  21675, 37626,  7333, 3996,  1016,   428438, 187728;
    20200211,  16067, 38800,  8204, 4740,  1113,   451462, 185037;
    20200212,  13435, 52526,  8030, 5911,  1367,   471531, 181386;
    20200213,  10109, 55748,  10204, 6723,  1380,   493067, 177984`;
    const columnMap = {
        '日期' : 0,
        '疑似' : 1,
        '确诊' : 2,
        '重症' : 3,
        '治愈' : 4,
        '死亡' : 5,
        '接触' : 6,
        '观察' : 7
    };
    let extract = function (columnName) {
        let lines = originData.split(";");
        let data = [];
        for( i = 1; i < lines.length; i++ ) {
            let fields = lines[i].split(",");
            data.push(parseInt(fields[columnMap[columnName]]))
        };
        return data;
    };
    var ctx = document.getElementById('myChart-a').getContext('2d');
    let labels = extract('日期');
    let s1 = extract('疑似');
    let s2 = extract('确诊');
    let s2_1 = [];
    for( i = 0; i < s1.length; i++ ) {
        s2_1.push( s1[i] + s2[i]);
    }
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            datasets: [{
                label: '疑似',
                data: s1,
                borderColor: 'orange',
                borderWidth: 1,
                // this dataset is drawn below
                order: 2
            }, {
                label: '确诊',
                data: s2,
                type: 'line',
                borderColor: 'red',
                borderWidth: 1,
                // this dataset is drawn on top
                order: 3
            }, {
                label: '疑似+确诊',
                data: s2_1,
                type: 'line',
                borderColor: 'purple',
                borderWidth: 1,
                // this dataset is drawn on top
                order: 4
            }],
            labels: labels
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes:[{
                    ticks: {
                        autoSkip: true,
                        maxRotation: 0,
                        minRotation: 0
                    }
                }]
            }
        }
    });
    let s3 = extract('重症');
    let s4 = extract('治愈');
    let s5 = extract('死亡');
    var ctxb = document.getElementById('myChart-b').getContext('2d');
    var myChartb = new Chart(ctxb, {
        type: 'line',
    data: {
        datasets: [{
            label: '在治重症',
            data: s3,
            type: 'line',
            borderColor: 'red',
            borderWidth: 1,
            // this dataset is drawn on top
            order: 3
        },{
            label: '治愈',
            data: s4,
            type: 'line',
            borderColor: 'green',
            borderWidth: 2,
            // this dataset is drawn on top
            order: 4
        },{
            label: '死亡',
            data: s5,
            type: 'line',
            borderColor: 'black',
            borderWidth: 1,
            // this dataset is drawn on top
            order: 5
        }],
        labels: labels
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes:[{
                        ticks: {
                        autoSkip: true,
                        maxRotation: 0,
                        minRotation: 0
                    }
                }]
            }
        }
    });
    let s6 = extract('接触');
    let s7 = extract('观察');
    var ctxc = document.getElementById('myChart-c').getContext('2d');
    var myChartc = new Chart(ctxc, {
        type: 'line',
     data: {
        datasets: [{
            label: '密切接触',
            data: s6,
            type: 'line',
            borderColor: 'orange',
            borderWidth: 1,
            // this dataset is drawn on top
            order: 5
        },{
            label: '医学观察',
            data: s7,
            type: 'line',
            borderColor: 'red',
            borderWidth: 1,
            // this dataset is drawn on top
            order: 5
        }],
        labels: labels
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes:[{
                    ticks: {
                        autoSkip: true,
                        maxRotation: 0,
                        minRotation: 0
                    }
                }]
            }
        }
    });
    </script>
</div>
<div>
    <div>
        <h3>每日新增 确诊、疑似</h3>
        <canvas id="myChart-d" width="400" height="240"></canvas>
    </div>
    <br/>
    <div>
        <h3>湖北以外每日新增 确诊、疑似</h3>
        <canvas id="myChart-d2" width="400" height="240"></canvas>
    </div>
    <br/>
    <div>
        <h3>每日新增 重症、死亡、治愈</h3>
        <canvas id="myChart-e" width="400" height="240"></canvas>
    </div>
    <br/>
    <div>
        <h3>每日新增 医学观察</h3>
        <canvas id="myChart-f" width="400" height="240"></canvas>
    </div>
    <br/>
    <script>
    let extractDelta = function (columnName) {
        let data = extract(columnName);
        if ( columnName === '日期') {
            return data.slice(1);
        }
        let dataDelta = [];
        for ( i = 1; i < data.length; i++ ) {
            dataDelta.push( data[i] - data[i-1]);
        }
        return dataDelta;
    };
    const columnMapDelta = {
        '日期' : 0,
        '疑似' : 1,
        '确诊' : 2,
        '重症' : 3,
        '治愈' : 4,
        '死亡' : 5,
        '疑似(湖北)' : 6,
        '确诊(湖北)' : 7,
        '重症(湖北)' : 8,
        '治愈(湖北)' : 9,
        '死亡(湖北)' : 10
    };
    let extractDeltaOutHubei = function (columnName) {
        let lines = originDataDelta.split(";");
        let data = [];
        for( i = 1; i < lines.length; i++ ) {
            let fields = lines[i].split(",");
            data.push(parseInt(fields[columnMapDelta[columnName]]))
        };
        return data;
    }; // 7593,1685, 5674,1437
    const originDataDelta =
    `日期,      疑似,  确诊,  重症,  治愈,  死亡,  疑似(湖北),  确诊(湖北),  重症(湖北),  治愈(湖北),  死亡(湖北);
    20200201,  4562,  2590,  315,   85,    45,    2606,        1921,        268,         49,          45;
    20200202,  5173,  3260,  186,   147,   57,    3260,        2103,        139,         80,          56;
    20200203,  5072,  3235,  492,   157,   64,    3182,        2345,        492,         101,         64;
    20200204,  3917,  3887,  431,   262,   65,    1957,        3159,        377,         125,         65;
    20200205,  5328,  3694,  640,   261,   73,    3230,        2987,        564,         113,         70;
    20200206,  4833,  3134,  962,   387,   73,    2622,        2447,        918,         184,         69;
    20200207,  4214,  3399,  1280,  510,   86,    2073,        2841,        1193,        298,         81;
    20200208,  3916,  2656,  87,    599,   89,    2067,        2147,        52,          324,         81;
    20200209,  4008,  3062,  296,    632,  97,    2272,        2618,        258,          356,        91;
    20200210,  3536,  2478,  849,    715,  108,   2272,        1814,        839,          427,        103;
    20200211,  3342,  2015,  871,    744,  97,    1685,        1638,        897,          417,        94;
    20200212,  2807,  15152,  -174,  1171,  254,  1377,        14840,        -157,          802,        242;
    20200213,  2450,  5090,  2174,    812,  121,  1154,        4823,        2167,          690,        242`;
    var ctxd = document.getElementById('myChart-d').getContext('2d');
    let labelsd = extractDelta('日期');
    let sd1 = extractDelta('疑似');
    let sd2 = extractDelta('确诊');
    let sd2_1 = [];
    for( i = 0; i < s1.length; i++ ) {
        sd2_1.push( s1[i+1] + s2[i+1] - s1[i] - s2[i]);
    }
    var myChartd = new Chart(ctxd, {
        type: 'line',
        data: {
            datasets: [{
                label: '疑似',
                data: sd1,
                borderColor: 'orange',
                borderWidth: 1,
                // this dataset is drawn below
                order: 2
            }, {
                label: '确诊',
                data: sd2,
                type: 'line',
                borderColor: 'red',
                borderWidth: 1,
                // this dataset is drawn on top
                order: 3
            }, {
                label: '确诊 | 疑似',
                data: sd2_1,
                type: 'line',
                borderColor: 'purple',
                borderWidth: 1,
                // this dataset is drawn on top
                order: 3
            }],
            labels: labelsd
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes:[{
                    ticks: {
                        autoSkip: true,
                        maxRotation: 0,
                        minRotation: 0
                    }
                }]
            }
        }
    });
    let sd1_10 = extractDeltaOutHubei('疑似');
    let sd2_20 = extractDeltaOutHubei('确诊');
    let sd1_1 = extractDeltaOutHubei('疑似(湖北)');
    let sd2_2 = extractDeltaOutHubei('确诊(湖北)');
    let sd2_3 = [];
    let sd2_4 = [];
    let sd2_5 = [];
    for( i = 0; i < sd1_1.length; i++ ) {
        sd2_3.push( sd1_10[i] - sd1_1[i]);
        sd2_4.push( sd2_20[i] - sd2_2[i]);
        sd2_5.push( sd2_3[i] + sd2_4[i]);
    }
    let labelsd2 = extractDeltaOutHubei('日期');
    var ctxd2 = document.getElementById('myChart-d2').getContext('2d');
    var myChartd2 = new Chart(ctxd2, {
        type: 'line',
        data: {
            datasets: [{
                label: '疑似(湖北以外)',
                data: sd2_3,
                borderColor: 'orange',
                borderWidth: 1,
                // this dataset is drawn below
                order: 2
            }, {
                label: '确诊(湖北以外)',
                data: sd2_4,
                type: 'line',
                borderColor: 'red',
                borderWidth: 1,
                // this dataset is drawn on top
                order: 3
            }, {
                label: '确诊 | 疑似 (湖北以外)',
                data: sd2_5,
                type: 'line',
                borderColor: 'purple',
                borderWidth: 1,
                // this dataset is drawn on top
                order: 3
            }],
            labels: labelsd2
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes:[{
                    ticks: {
                        autoSkip: true,
                        maxRotation: 0,
                        minRotation: 0
                    }
                }]
            }
        }
    });
    let se3 = extractDelta('重症');
    let se4 = extractDelta('治愈');
    let se5 = extractDelta('死亡');
    var ctxe = document.getElementById('myChart-e').getContext('2d');
    var myCharte = new Chart(ctxe, {
        type: 'line',
    data: {
        datasets: [{
            label: '在治重症变化',
            data: se3,
            type: 'line',
            borderColor: 'red',
            borderWidth: 1,
            // this dataset is drawn on top
            order: 3
        },{
            label: '治愈',
            data: se4,
            type: 'line',
            borderColor: 'green',
            borderWidth: 2,
            // this dataset is drawn on top
            order: 4
        },{
            label: '死亡',
            data: se5,
            type: 'line',
            borderColor: 'black',
            borderWidth: 1,
            // this dataset is drawn on top
            order: 5
        }],
        labels: labelsd
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes:[{
                        ticks: {
                        autoSkip: true,
                        maxRotation: 0,
                        minRotation: 0
                    }
                }]
            }
        }
    });
    let sf6 = extractDelta('接触');
    let sf7 = extractDelta('观察');
    var ctxf = document.getElementById('myChart-f').getContext('2d');
    var myChartf = new Chart(ctxf, {
        type: 'line',
     data: {
        datasets: [{
            label: '密切接触',
            data: sf6,
            type: 'line',
            borderColor: 'orange',
            borderWidth: 1,
            // this dataset is drawn on top
            order: 5
        },{
            label: '医学观察',
            data: sf7,
            type: 'line',
            borderColor: 'red',
            borderWidth: 1,
            // this dataset is drawn on top
            order: 5
        }],
        labels: labelsd
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes:[{
                    ticks: {
                        autoSkip: true,
                        maxRotation: 0,
                        minRotation: 0
                    }
                }]
            }
        }
    });
    </script>
</div>

## 附件 数据表一
|日期|      疑似|  确诊|  重症|  治愈|  死亡|  接触|   观察|
|----|---------|-----|-----|------|------|-----|------|
|20200120|  54|    291|   63|    25|    6|     1739|   922|
|20200121|  37|    440|   102|   25|    9|     2197|   1394|
|20200122|  393|   571|   95|    25|    17|    5897|   4928|
|20200123|  1072|  830|   177|   34|    25|    9507|   8420|
|20200124|  1965|  1287|  237|   38|    41|    15197|  13976|
|20200125|  2684|  1975|  324|   49|    56|    23431|  21556|
|20200126|  5794|  2744|  461|   51|    80|    32799|  30453|
|20200127|  6973|  4515|  976|   60|    106|   47833|  44132|
|20200128|  9239|  5947|  1239|  103|   132|   65537|  59990|
|20200129|  12167| 7711|  1370|  124|   170|   88693|  81947|
|20200130|  15238| 9692|  1527|  171|   213|   113579| 102427|
|20200131|  17988| 11791|  1795| 243|   259|   136987| 118478|
|20200201|  19544| 14380|  2110| 328|   304|   163844| 137594|
|20200202|  21558| 17205|  2296| 475|   361|   189583| 152700|
|20200203|  23214| 20438|  2788| 632|   425|   221015| 171329|
|20200204|  23260| 24324|  3219| 892|   490|   252154| 185555|
|20200205|  24702| 28018|  3859| 1153|  563|   282813| 186354|
|20200206|  26359| 28985|  4821| 1540|  636|   314028| 186045|
|20200207|  27657| 31774|  6101| 2050|  722|   345498| 189660|
|20200208|  28942| 33738|  6188| 2649|  811|   371905| 188183|
|20200209|  23589| 35982|  6489| 3281|  908|   399487| 187157|
|20200210|  21675| 37626|  7333| 3996|  1016|   428438| 187728|
|20200211|  16067| 38800|  8204| 4740|  1113|   451462| 185037|
|20200212|  13435| 52526|  8030| 5911|  1367|   471531| 181386|
|20200213|  10109| 55748| 10204| 6723|  1380|   493067| 177984|

## 附件二 每日新增数据表
|日期|      疑似|  确诊|  重症|  治愈|  死亡|  疑似(湖北)|  确诊(湖北)|  重症(湖北)|  治愈(湖北)|  死亡(湖北)|
|---|----------|-----|------|-----|------|----------|-----------|----------|-----------|----------|
|20200201|  4562|  2590|  315|   85|    45|    2606|        1921|        268|         49|          45|
|20200202|  5173|  3260|  186|   147|   57|    3260|        2103|        139|         80|          56|
|20200203|  5072|  3235|  492|   157|   64|    3182|        2345|        492|         101|         64|
|20200204|  3917|  3887|  431|   262|   65|    1957|        3159|        377|         125|         65|
|20200205|  5328|  3694|  640|   261|   73|    3230|        2987|        564|         113|         70|
|20200206|  4833|  3134|  962|   387|   73|    2622|        2447|        918|         184|         69|
|20200207|  4214|  3399|  1280|  510|   86|    2073|        2841|        1193|        298|         81|
|20200208|  3916|  2656|  87|    599|   89|    2067|        2147|        52|          324|         81|
|20200209|  4008|  3062|  296|    632|  97|    2272|        2618|        258|          356|        91|
|20200210|  3536|  2478|  849|    715|  108|   2272|        1814|        839|          427|        103|
|20200211|  3342|  2015|  871|    744|  97|    1685|        1638|        897|          417|        94|
20200212|  2807|  15152|  -174|  1171|  254|  1377|        14840|        -157|          802|        242|
20200213|  2450|  5090|  2174|    812|  121|  1154|        4823|        2167|          690|        242|