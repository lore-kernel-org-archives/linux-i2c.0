From: "naveen krishna ch" <naveenkrishna.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c 2 issues on omap3430
Date: Mon, 25 Aug 2008 18:39:20 +0530
Message-ID: <ef0d8a250808250609i2d95bdb8x5fa0bd78368bf610@mail.gmail.com>
References: <ef0d8a250808250005sbf8bb8cg9cfacc6a6f2b4195@mail.gmail.com>
	<ef0d8a250808250018w587c2de0s726511c52c0794e3@mail.gmail.com>
	<48B29D85.5030208@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9095343333255843466=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48B29D85.5030208-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Nishanth Menon <menon.nishanth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============9095343333255843466==
Content-Type: multipart/alternative;
	boundary="----=_Part_67452_29481420.1219669760938"

------=_Part_67452_29481420.1219669760938
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Hi,

         I am working on a touch pad driver which uses i2c reads and writes
to the touch pad registers. But, i observe the i2c reads are not consistent.
when i try to read the Manufacturer information i get some junk values. when
i try resetting all the register and read those values i get some other
unexpected values.

I feel like its a serious OMAP3 I2C-2 timing issue.

         But with same uImage some times i get correct values.

Do any one know what i am missing on. and how to debug this issue.


Thankfull for your suggestions.

>
>


(: Naveen Krishna Ch :)

------=_Part_67452_29481420.1219669760938
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi, </blockquote><div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am working on a touch pad driver which uses i2c reads and writes to the touch pad registers. But, i observe the i2c reads are not consistent. when i try to read the Manufacturer information i get some junk values. when i try resetting all the register and read those values i get some other unexpected values. <br>
<br>I feel like its a serious OMAP3 I2C-2 timing issue.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; But with same uImage some times i get correct values. <br><br>Do any one know what i am missing on. and how to debug this issue. <br><br><br>Thankfull for your suggestions.<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
</blockquote></div><br><br><br>(: Naveen Krishna Ch :)<br>
</div>

------=_Part_67452_29481420.1219669760938--


--===============9095343333255843466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============9095343333255843466==--
