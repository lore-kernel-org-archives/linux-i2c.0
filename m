From: "Wen Wang" <sickdoctor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Access 16bits address register in a device through I2C
Date: Fri, 18 Jul 2008 10:51:35 +0800
Message-ID: <56458e0807171951k3dba3d7eree400ee1ccfadf61@mail.gmail.com>
References: <56458e0807170913k10adc9k2c479eddbe600fdb@mail.gmail.com>
	<20080717170649.GD4199@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0904777924569864168=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080717170649.GD4199-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============0904777924569864168==
Content-Type: multipart/alternative;
	boundary="----=_Part_5852_25236425.1216349495719"

------=_Part_5852_25236425.1216349495719
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guys,

Thank you for your kindly heads up, that really helps me a lot :)

BRs
Wen

On Fri, Jul 18, 2008 at 1:06 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:

> Hi Wen,
>
> On Fri, Jul 18, 2008 at 12:13:30AM +0800, Wen Wang wrote:
>
> > So I'm wondering do I miss something or what can I do? Any ideas?
>
> For an example what Ben suggested (2 messages), have a look at the
> at24-driver, which just went through the merge-window.
>
> http://article.gmane.org/gmane.linux.drivers.i2c/1661
>
> Check functions 'at24_eeprom_[read|write]' for details.
>
> All the best,
>
>   Wolfram
>
> --
>  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
>
> iD8DBQFIf3wpD27XaX1/VRsRAjXBAKCx28nzPbkyMx3aN6KNN03jNFIRLwCgiyAL
> +zHcrnvXfuzWngEpflY5KZg=
> =sUwl
> -----END PGP SIGNATURE-----
>
>

------=_Part_5852_25236425.1216349495719
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Guys,<br>

<br>

Thank you for your kindly heads up, that really helps me a lot :)<br>

<br>

BRs<br>

Wen<br><br><div class="gmail_quote">On Fri, Jul 18, 2008 at 1:06 AM, Wolfram Sang &lt;<a href="mailto:w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org">w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Wen,<br>
<div class="Ih2E3d"><br>
On Fri, Jul 18, 2008 at 12:13:30AM +0800, Wen Wang wrote:<br>
<br>
</div><div class="Ih2E3d">&gt; So I&#39;m wondering do I miss something or what can I do? Any ideas?<br>
<br>
</div>For an example what Ben suggested (2 messages), have a look at the<br>
at24-driver, which just went through the merge-window.<br>
<br>
<a href="http://article.gmane.org/gmane.linux.drivers.i2c/1661" target="_blank">http://article.gmane.org/gmane.linux.drivers.i2c/1661</a><br>
<br>
Check functions &#39;at24_eeprom_[read|write]&#39; for details.<br>
<br>
All the best,<br>
<br>
 &nbsp; Wolfram<br>
<font color="#888888"><br>
--<br>
 &nbsp;Dipl.-Ing. Wolfram Sang | <a href="http://www.pengutronix.de" target="_blank">http://www.pengutronix.de</a><br>
&nbsp;Pengutronix - Linux Solutions for Science and Industry<br>
</font><br>-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.6 (GNU/Linux)<br>
<br>
iD8DBQFIf3wpD27XaX1/VRsRAjXBAKCx28nzPbkyMx3aN6KNN03jNFIRLwCgiyAL<br>
+zHcrnvXfuzWngEpflY5KZg=<br>
=sUwl<br>
-----END PGP SIGNATURE-----<br>
<br></blockquote></div><br></div>

------=_Part_5852_25236425.1216349495719--


--===============0904777924569864168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============0904777924569864168==--
