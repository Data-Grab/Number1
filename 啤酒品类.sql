DECLARE @取数日期 DATE;
SET @取数日期	= '2022-06-30';
DECLARE @结束日期 DATE;
SET @结束日期	= '2022-06-30  ';

--- 品类
SELECT
dw_regionalgood_Y22M1.[大区],
dw_regionalgood_Y22M1.[账单日期],
dw_regionalgood_Y22M1.[2位类别],
SUM(dw_regionalgood_Y22M1.[商品原价销售额])'原价销售额',
SUM(dw_regionalgood_Y22M1.[商品销售数量])'销量',
SUM(dw_regionalgood_Y22M1.[商品实付销售额])'实付销售额',
SUM(dw_regionalgood_Y22M1.[商品商家补贴金额])'商家补贴金额',
SUM(dw_regionalgood_Y22M1.[商品平台补贴金额])'平台补贴金额',
SUM(dw_regionalgood_Y22M1.[商品实收])'实收金额'

FROM
dw_regionalgood_Y22M1

WHERE dw_regionalgood_Y22M1.[平台] = '美团'
AND dw_regionalgood_Y22M1.[2位类别] = '28啤酒／预调酒'
AND dw_regionalgood_Y22M1.[账单日期] BETWEEN @取数日期 AND @结束日期
AND dw_regionalgood_Y22M1.[大区] IN ('潮汕','佛山','中江珠','东一','广二','茂湛','粤东','清韶肇','阳云','东二','广一','深二','深一')
AND dw_regionalgood_Y22M1.[行政区域] = '广东'
GROUP BY
dw_regionalgood_Y22M1.[大区],
dw_regionalgood_Y22M1.[账单日期],
dw_regionalgood_Y22M1.[2位类别]

UNION ALL

SELECT
dw_regionalgood_Y22M1.[大区],
dw_regionalgood_Y22M1.[账单日期],
'大盘' AS '2位类别',
SUM(dw_regionalgood_Y22M1.[商品原价销售额])'原价销售额',
SUM(dw_regionalgood_Y22M1.[商品销售数量])'销量',
SUM(dw_regionalgood_Y22M1.[商品实付销售额])'实付销售额',
SUM(dw_regionalgood_Y22M1.[商品商家补贴金额])'商家补贴金额',
SUM(dw_regionalgood_Y22M1.[商品平台补贴金额])'平台补贴金额',
SUM(dw_regionalgood_Y22M1.[商品实收])'实收金额'

FROM
[彩聚零售].dbo.dw_regionalgood_Y22M1

WHERE dw_regionalgood_Y22M1.[平台] = '美团'
AND dw_regionalgood_Y22M1.[账单日期] BETWEEN @取数日期 AND @结束日期
AND dw_regionalgood_Y22M1.[大区] IN ('潮汕','佛山','中江珠','东一','广二','茂湛','粤东','清韶肇','阳云','东二','广一','深二','深一')
AND dw_regionalgood_Y22M1.[行政区域] = '广东'

GROUP BY
dw_regionalgood_Y22M1.[大区],
dw_regionalgood_Y22M1.[账单日期]


UNION ALL
SELECT
dw_regionalgood_Y22M1.[大区],
dw_regionalgood_Y22M1.[账单日期],
'28啤酒／预调酒(组合)' AS '2位类别',
SUM(dw_regionalgood_Y22M1.[商品原价销售额])'原价销售额',
SUM(dw_regionalgood_Y22M1.[商品销售数量])'销量',
SUM(dw_regionalgood_Y22M1.[商品实付销售额])'实付销售额',
SUM(dw_regionalgood_Y22M1.[商品商家补贴金额])'商家补贴金额',
SUM(dw_regionalgood_Y22M1.[商品平台补贴金额])'平台补贴金额',
SUM(dw_regionalgood_Y22M1.[商品实收])'实收金额'
FROM
[彩聚零售].dbo.dw_regionalgood_Y22M1
INNER JOIN [测试BI].dbo.[啤酒组合代码]
ON [啤酒组合代码].[国际条形码] = dw_regionalgood_Y22M1.[UPC码]


WHERE dw_regionalgood_Y22M1.[平台] = '美团'
AND dw_regionalgood_Y22M1.[账单日期] BETWEEN @取数日期 AND @结束日期
AND dw_regionalgood_Y22M1.[大区] IN ('潮汕','佛山','中江珠','东一','广二','茂湛','粤东','清韶肇','阳云','东二','广一','深二','深一')
AND dw_regionalgood_Y22M1.[行政区域] = '广东'

GROUP BY
dw_regionalgood_Y22M1.[大区],
dw_regionalgood_Y22M1.[账单日期]
;
