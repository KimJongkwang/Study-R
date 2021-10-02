#
# sprintf() : 문자열을 원하는 포맷으로 변환하여 출력하는 함수
# sprintf("str", string value)
args <- c("2021", "10", "2", "21")
yy <- sprintf("%04d", as.numeric(args[1]))
mm <- sprintf("%02d", as.numeric(args[2]))
dd <- sprintf("%02d", as.numeric(args[3]))
hh <- sprintf("%02d", as.numeric(args[4]))

# strptime() : 문자열을 받아 POSIXlt, POSIXt 클래스로 변환
datetime <- strptime(paste0(yy,"-",mm,"-",dd," ",hh,":00:00"), "%Y-%m-%d %H:%M:%S")

# format() : 문자열을 원하는 포맷으로 변환
## 위에서 만든 datetime에 10시간을 더한뒤 출력 포맷 변환
datetime2 <- format(datetime + (3600 * 10), "%Y%m%d%H00")
