-- �ΏۃA�v��
set target to "Kindle"

-- �ۑ��t�H���_
set savepath to "~/Desktop/Test/"
do shell script "mkdir " & savepath

-- �J�n�t�@�C���ԍ�
set spage to 1
-- �y�[�W��
set pages to 400
-- �߂������(1=�� 2=�E)
set pagedir to 2
-- �y�[�W�߂���E�G�C�g(�b)
set pausetime to 1.0

-- �؂蔲���摜offset(���ォ��)
set offsetx to 100
set offsety to 180
set cropOffSet to " --cropOffset " & offsety & " " & offsetx & " "
log cropOffSet

-- �؂蔲���T�C�Y(���ォ�炩��)
set cropx to 3200
set cropy to 1950
set cropXy to " -c " & cropy & " " & cropx & " "
log cropXy

-- ���T�C�Y��(�؂蔲���O�̃T�C�Y���Z=��ʉ�/�؂蔲����*�d�オ�艡)
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
