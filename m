From: "Darren Zhang" <darrentw-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: driver support for smbus mux
Date: Tue, 29 Apr 2008 16:00:29 -0700
Message-ID: <d4d59c9a0804291600s744e27bfta8144d376824ea58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0274811978655460134=="
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

--===============0274811978655460134==
Content-Type: multipart/alternative;
	boundary="----=_Part_5444_22409978.1209510029897"

------=_Part_5444_22409978.1209510029897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In my system the I2C bus is multiplexed into 4 segments using an analog
multiplexer.
When I use i2cdetect, only devices before the i2c mux can be detected.
I wonder if this kind of hardware configuration is supported in the latest
2.6 kernal
s.t. I can use i2ctools (i2cdetect/i2cdump/i2cset) to access devices behind
the i2c mux?
Any suggestion appreciated.

                         -------------- <-------->
                        | i2c mux | <-------->
   i2c-0 <------->  |             | <-------->
                        |             | <-------->
                         -------------

Thanks

------=_Part_5444_22409978.1209510029897
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>In my system the I2C bus is multiplexed into 4 segments using an analog multiplexer.</div>
<div>When I use i2cdetect, only devices&nbsp;before the i2c mux can be detected.</div>
<div>I wonder if&nbsp;this kind of hardware&nbsp;configuration is supported in the latest 2.6 kernal&nbsp;</div>
<div>s.t. I can&nbsp;use i2ctools (i2cdetect/i2cdump/i2cset) to access devices behind the&nbsp;i2c mux?</div>
<div>Any suggestion appreciated.</div>
<div><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -------------- &lt;--------&gt;&nbsp; </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | i2c mux | &lt;--------&gt;&nbsp;<br>&nbsp;&nbsp; i2c-0 &lt;-------&gt;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | &lt;--------&gt;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | &lt;--------&gt;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -------------<br>
<br>Thanks&nbsp;</div>

------=_Part_5444_22409978.1209510029897--


--===============0274811978655460134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============0274811978655460134==--
