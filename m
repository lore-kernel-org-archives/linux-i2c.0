From: "Wen Wang" <sickdoctor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Access 16bits address register in a device through I2C
Date: Fri, 18 Jul 2008 00:13:30 +0800
Message-ID: <56458e0807170913k10adc9k2c479eddbe600fdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4467354145804768157=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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

--===============4467354145804768157==
Content-Type: multipart/alternative;
	boundary="----=_Part_1636_20084482.1216311210603"

------=_Part_1636_20084482.1216311210603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
I have a problem writing an I2C device driver and would greatly appreciate
if someone could provide some enlightenment.

I'm working on a project needs to access registers with 16bits address
through I2C. But unfortunately I can not find a way to achieve this, cause
it seems that current kernel I2C framework only supports 8bits address
register.

So I'm wondering do I miss something or what can I do? Any ideas?

Thanks
Wen

------=_Part_1636_20084482.1216311210603
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div>Hi all,</div>
<div>I have a problem writing an I2C device driver and would greatly appreciate if someone could provide some enlightenment.</div>
<div><br>I&#39;m working on a project needs to access registers with 16bits address through I2C. But unfortunately I can not find a way to achieve this, cause it seems that current kernel I2C framework only supports 8bits address register.</div>

<p>So I&#39;m wondering do I miss something or what can I do? Any ideas?</p>
<p>Thanks<br>Wen</p>
<p>&nbsp;</p></div>

------=_Part_1636_20084482.1216311210603--


--===============4467354145804768157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4467354145804768157==--
