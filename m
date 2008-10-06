From: "naveen krishna ch" <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I2C reads and writes
Date: Mon, 6 Oct 2008 14:12:22 +0530
Message-ID: <ef0d8a250810060142k620ccd0h346724f7f8f507c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1938286238330653583=="
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

--===============1938286238330653583==
Content-Type: multipart/alternative;
	boundary="----=_Part_38127_32623172.1223282542920"

------=_Part_38127_32623172.1223282542920
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I am working on a device driver (One touch). The registers of which are
16bit wide and are addressed by 16 bit address.
The SMBus supports 16 bit read but address cannot be 16 bit in that case.

I used the i2c_transfer, i2c_master_send and i2c_master_recv  combinations
to read and write data to and from the
registers of the device. Is this a good and neater way to do so. If not can
anyone suggest me a better one.


-- 
Thanks,
Nayva

------=_Part_38127_32623172.1223282542920
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi all, <br><br>I am working on a device driver (One touch). The registers of which are 16bit wide and are addressed by 16 bit address.<br>The SMBus supports 16 bit read but address cannot be 16 bit in that case.<br>
<br>I used the i2c_transfer, i2c_master_send and i2c_master_recv&nbsp; combinations to read and write data to and from the <br>registers of the device. Is this a good and neater way to do so. If not can anyone suggest me a better one.<br>
<br clear="all"><br>-- <br>Thanks, <br>Nayva<br>
</div>

------=_Part_38127_32623172.1223282542920--


--===============1938286238330653583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1938286238330653583==--
