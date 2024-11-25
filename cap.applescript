-- 対象アプリ
set target to "Kindle"

-- 保存フォルダ
set savepath to "~/Desktop/DfD/"

-- 開始ファイル番号
set spage to 1

-- ページ数
set pages to 400

-- めくり方向(1=左 2=右)
set pagedir to 2

-- ページめくりウエイト(秒)
set pausetime to 1.0

-- 切り抜き画像offset(左上から)
set offsetx to 100
set offsety to 180
set cropOffSet to " --cropOffset " & offsety & " " & offsetx & " "
log cropOffSet

-- 切り抜きサイズ(左上からから)
set cropx to 3200
set cropy to 1950
set cropXy to " -c " & cropy & " " & cropx & " "
log cropXy

-- リサイズ横(切り抜く前のサイズ換算=画面横/切り抜き横*仕上がり横)
set resizew to 0

if pagedir = 1 then
	set keychar to (ASCII character 28)
else
	set keychar to (ASCII character 29)
end if

if target is not "" then
	tell application target
		activate
	end tell
end if

delay pausetime
repeat with i from spage to pages
	if i < 10 then
		set dp to "00" & i
	else if i < 10000000 then
		set dp to "0" & i
	end if

	set spath to (savepath & "p" & dp & ".png")
	do shell script "screencapture -x " & spath

	if cropx is not 0 and cropy is not 0 then
		if resizew is not 0 then
			do shell script "sips -c " & cropy & " " & cropx & " --resampleWidth " & resizew & " " & spath & " --out " & spath
		else
			set sipsCommand to "sips " & cropOffSet & " " & cropXy & " " & spath & " --out " & spath
			log sipsCommand
			do shell script sipsCommand
		end if
	end if

	tell application "System Events"
		keystroke keychar
	end tell

	delay pausetime
end repeat
activate
