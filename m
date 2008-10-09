From: "srinivas ramana" <srinivas.ramana-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: FW: Regd. i2c-dev and SMBALERT#
Date: Thu, 9 Oct 2008 12:45:36 +0530
Message-ID: <fb851e120810090015j67d8b881l6e8956c78025fb86@mail.gmail.com>
References: <34BAE4FA891DCA498C6D46840F4F896F4B8D5D@BLR-SJP-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0151843966225180438=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <34BAE4FA891DCA498C6D46840F4F896F4B8D5D-oXGDjV/NE2WrH2xbGxYgkoJt+NpFC6AG@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: srinivas.ramana-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============0151843966225180438==
Content-Type: multipart/alternative;
	boundary="----=_Part_117477_29023241.1223536536080"

------=_Part_117477_29023241.1223536536080
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

Extremely sorry for the disclaimer in previous mail. will take care from
next time.

Regd my questions, I understood only one advantage of user space drivers,
that is,
a. any mistakes in user space will not effect entire system.

I am very interested to know all the important pros/cons of user
space/kernel space I2C drivers.

I also understood that user space driver can not handle interrupts. So, how
does the SMBALERT# be handled for the devices which support the same.

Request you to provide some understanding for the questions in below mail
too.
Thanks in advance.

Thanks & Regards,
-- Srinivas R



On Wed, Oct 8, 2008 at 3:40 PM, <srinivas.ramana-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org> wrote:

>
>
>  ------------------------------
> *From:* Srinivas Ramana (WT01 - PES - Peripheral(Techology))
> *Sent:* Tuesday, October 07, 2008 5:13 PM
> *To:* 'i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org'
> *Subject:* Regd. i2c-dev and SMBALERT#
>
>  Hi All,
>
> 1. I would like to know the advantages and disadvantages of user space
> driver for I2C using i2c-dev, compared to the kernel mode drivers.
>
> 2. What happens if a driver is already bind to the device and application
> tries to open/use it using i2c-dev?
>
> 3. My understanding on SMBALERT# is that it provides the I2C/SMBus device
> to interrupt the host.
>         a. The driver for SMBALERT# is different from the adapter driver?
>         b. What kind of support is provided for SMBALERT# in current
> kernels?
>
> Request your help in understanding the above.
>
>
> Thanks & Regards,
> -- Srinivas R
>

------=_Part_117477_29023241.1223536536080
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi All,<br><br>Extremely sorry for the disclaimer in previous mail. will take care from next time.<br><br>Regd my questions, I understood only one advantage of user space drivers, that is,<br>a. any mistakes in user space will not effect entire system.<br>
<br>
I am very interested to know all the important pros/cons of user space/kernel space I2C drivers.<br><br>I also understood that user space driver can not handle interrupts. So, how does the SMBALERT# be handled for the devices which support the same.<br>
<br>Request you to provide some understanding for the questions in below mail too.<br>Thanks in advance. <br><br>Thanks &amp; Regards,<br>-- Srinivas R<br><br><br><br><div class="gmail_quote">
On Wed, Oct 8, 2008 at 3:40 PM,  <span dir="ltr">&lt;<a href="mailto:srinivas.ramana-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org" target="_blank">srinivas.ramana-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">





<div>
<div>&nbsp;</div><br>
<div dir="ltr" align="left" lang="en-us">
<hr>
<font face="Tahoma" size="2"><b>From:</b> Srinivas Ramana (WT01 - PES - 
Peripheral(Techology)) <br><b>Sent:</b> Tuesday, October 07, 2008 5:13 
PM<br><b>To:</b> &#39;<a href="mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" target="_blank">i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org</a>&#39;<br><b>Subject:</b> Regd. i2c-dev and 
SMBALERT#<br></font><br></div>
<div></div>
<div><font face="Arial" size="2"><span>Hi 
All,</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>1. I would like to 
know the advantages and disadvantages of user space driver for I2C using 
i2c-dev, compared to the kernel mode drivers.</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>2. What happens if a 
driver is already bind to the device and application tries to open/use it using 
i2c-dev?</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>3. My understanding 
on SMBALERT# is that it provides the I2C/SMBus device to interrupt the 
host.</span></font></div>
<div><font face="Arial" size="2"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a. The 
driver for SMBALERT# is different from the adapter driver?</span></font></div>
<div><font face="Arial" size="2"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b. What kind 
of support is provided for SMBALERT# in current kernels?</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>Request your help in 
understanding the&nbsp;above.</span></font></div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span></span></font>&nbsp;</div>
<div><font face="Arial" size="2"><span>Thanks &amp; 
Regards,</span></font></div>
<div><font face="Arial" size="2"><span>-- Srinivas 
R</span></font><br></div></div>
</blockquote></div><br></div>

------=_Part_117477_29023241.1223536536080--


--===============0151843966225180438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============0151843966225180438==--
