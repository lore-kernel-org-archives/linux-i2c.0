From: "naitik amin" <greatamin1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c-stub
Date: Thu, 2 Oct 2008 18:03:35 -0400
Message-ID: <aea25fc40810021503i13ea57cal183a7bf9bc88e351@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5220885455961582385=="
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

--===============5220885455961582385==
Content-Type: multipart/alternative;
	boundary="----=_Part_583_10759399.1222985015823"

------=_Part_583_10759399.1222985015823
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,

I was trying to use the i2c-stub driver.

What I did was I hardcoded the address to 0x23 and inserted the i2c-stub.ko

I then inserted ds1682.ko also part of the 2.6 kernel.

I was hoping to see that the probe function for ds1682.ko to be called but
it didn't.  Can someone comment on what I maybe missing.

Oh and BTW I did change the i2c_board_info by calling
i2c_register_board_info in machine level init. The parameters that I had
here were "ds1362" for driver name and 0x23 for address.

Thanks,

------=_Part_583_10759399.1222985015823
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi there,<br><br>I was trying to use the i2c-stub driver. <br><br>What I did was I hardcoded the address to 0x23 and inserted the i2c-stub.ko<br><br>I then inserted ds1682.ko also part of the 2.6 kernel.<br>
<br>I was hoping to see that the probe function for ds1682.ko to be called but it didn&#39;t.&nbsp; Can someone comment on what I maybe missing.<br><br>Oh and BTW I did change the i2c_board_info by calling i2c_register_board_info in machine level init. The parameters that I had here were &quot;ds1362&quot; for driver name and 0x23 for address.<br>
<br>Thanks,<br></div>

------=_Part_583_10759399.1222985015823--


--===============5220885455961582385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5220885455961582385==--
