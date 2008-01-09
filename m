From: "Ivo Manca" <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c-i801: Regression between 2.6.19-1 & 2.6.23.9
Date: Wed, 9 Jan 2008 12:08:28 +0100
Message-ID: <dba8564e0801090308j34215f98rd758dff3702b194@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hey all,

Trying to test  interrupt support for i801 I learned that somehow
between kernel version 2.6.22.14 and 2.6.23.9, something went wrong
with the bus driver. Is this a known issue?
When I try to use i2cdump to block-read an EEP OM, my i2cbus hangs.

Please find my output for 2.6.19-1 (working), 2.6.22.14-72 (working)
and 2.6.23.9-85 (not working).

Note: SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R)

Ivo

[root@localhost ~]# uname -r
2.6.19-1.2911.fc6

[root@localhost ~]# modprobe i2c-dev
[root@localhost ~]# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: 50 XX XX XX 54 55 XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX 73 XX XX XX XX

[root@localhost ~]# i2cdump -y 0 0x55 s
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u

[root@localhost ~]# i2cdump -y 0 0x55 s
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u

====

[root@localhost ~]# uname -r
2.6.22.14-72.fc6

[root@localhost ~]# modprobe i2c-dev

[root@localhost ~]# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: 50 XX XX XX 54 55 XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX 73 XX XX XX XX

[root@localhost ~]# i2cdump -y 0 0x55 s
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u

[root@localhost ~]# i2cdump -y 0 0x55 s
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u

====

[root@localhost ~]# uname -r
2.6.23.9-85.fc8

[root@localhost ~]# modprobe i2c-dev

[root@localhost ~]# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: 50 -- -- -- 54 55 -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
70: -- -- -- 73 -- -- -- --

[root@localhost ~]# i2cdump -y 0 0x55 s
Error: Block read failed, return code -1

[root@localhost ~]# i2cdump -y 0 0x55 s
Error: Block read failed, return code -1

(i2c Bus hangs completely, poweroff needed.)
