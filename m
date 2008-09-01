From: xiaowinky <nanguangzhixing-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: FW: HELP ME! DM355 EVM MT9T001 question!
Date: Tue, 2 Sep 2008 01:35:00 +0800
Message-ID: <BLU111-W4910427AB2C320E39BF04CB75C0@phx.gbl>
References: <rUwzhhPSZ00096e49@blu0-omc2-s21.blu0.hotmail.com>
	<BLU111-W21AE70F6BF9A6CFACB1D7AB7600@phx.gbl>
	<AEA06231B7D16F4CA77C0C1550F3D73005DDD727@sin2apfpew01.ap.sanm.corp>
	<BLU111-W438DFF6CC1D3E1028E9BB1B7600@phx.gbl>
	<bfd52c5b0808280642o5d30b0f1g77240bd5e0165b16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5826436404426486768=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <bfd52c5b0808280642o5d30b0f1g77240bd5e0165b16-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============5826436404426486768==
Content-Type: multipart/alternative;
	boundary="_305dcea9-fc0f-4df8-9dc9-959fcd5aed8e_"

--_305dcea9-fc0f-4df8-9dc9-959fcd5aed8e_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit

hi,all!  I use the i2c-tools-3.0.1 tool to compile and  install in DM355 EVM kernel, For example with orders #i2cdetect 0, prompts following information: WARNING! This program can confuse your I2C bus, cause data loss and worse!I will probe file /dev/i2c/0.I will probe address range 0x03-0x77.Continue? [Y/n]Then the basis bus address range 0x03-0x07,orders the test with below: #i2cdump 0 0x03-0x77, only 0x5D and 0x1B two bus addresses are effective, For example # i2cdump 0 0x5dprompt the information to be as follows:No size specified (using byte-data access)Error: Could not set address to 0x5d: Device or resource busy Other bus address is invalid, For example : # i2cdump 0 0x3aprompts the information to be as follows: No size specified (using byte-data access) WARNING! This program can con
 fuse your I2C bus, cause data loss and worse!I will probe file /dev/i2c/0, address 0x3a, mode byteContinue? [Y/n]
 
Whether only  0x5D and the 0xB1 two device address  hang on the I2C bus ???
 
First time with this tool software, everybody help explained in detail!
 
thanks everybody!
winkyxiao!
_________________________________________________________________
MSN 中文网，最新时尚生活资讯，白领聚集门户。
http://cn.msn.com
--_305dcea9-fc0f-4df8-9dc9-959fcd5aed8e_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 9pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class='hmmessage'>hi,all!<BR>&nbsp; I use the i2c-tools-3.0.1 tool to&nbsp;compile and&nbsp; install in DM355 EVM kernel,&nbsp;<BR>For example with orders #i2cdetect 0, <BR>prompts following information: <BR>WARNING! This program can confuse your I2C bus, cause data loss and worse!<BR>I will probe file /dev/i2c/0.<BR>I will probe address range 0x03-0x77.<BR>Continue? [Y/n]<BR><BR>Then the basis&nbsp;bus address range 0x03-0x07,orders the test with below: <BR>#i2cdump 0 0x03-0x77, <BR>only 0x5D and 0x1B two&nbsp;bus addresses are effective,&nbsp;For example # i2cdump 0 0x5d<BR>prompt the information to be as follows:<BR>No size specified (using byte-data access)<BR>Error: Could not set address to 0x5d: Device or resource busy<BR>&nbsp;<BR>Other&nbsp;bus address is invalid,&nbsp;For ex
 ample : # i2cdump 0 0x3a<BR>prompts the information to be as follows:<BR>&nbsp;No size specified (using byte-data access)<BR>&nbsp;WARNING! This program can confuse your I2C bus, cause data loss and worse!<BR>I will probe file /dev/i2c/0, address 0x3a, mode byte<BR>Continue? [Y/n]<BR>
&nbsp;<BR>
Whether only&nbsp; 0x5D and the 0xB1 two device address&nbsp; hang on the I2C bus ???<BR>
&nbsp;<BR>
First time with this tool software, everybody help explained in detail!<BR>
&nbsp;<BR>
thanks everybody!<BR>
winkyxiao!<BR><BR><BR><br /><hr />用MSN有问题？客服机器人小美帮你忙！ <a href='http://im.live.cn/xiaom/' target='_new'>立刻和小美聊天！</a></body>
</html>
--_305dcea9-fc0f-4df8-9dc9-959fcd5aed8e_--


--===============5826436404426486768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5826436404426486768==--
