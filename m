From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-mxs: fixed error message in pio transfer
Date: Tue, 09 Sep 2014 10:16:34 +0200
Message-ID: <540EB762.8090509@elproma.com.pl>
References: <540DEFA6.9030600@elproma.com.pl> <201409082014.07749.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201409082014.07749.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


W dniu 2014-09-08 20:14, Marek Vasut pisze:
> On Monday, September 08, 2014 at 08:04:22 PM, Janusz U=C5=BCycki wrot=
e:
>
> Thanks, but the Subject of the email doesn't make much sense. Also, a=
 short
> commit message exlaining what you did and why you did it would be nic=
e.
>
> While the patch is obvious and obviously correct, can you please fix =
those two
> minor things ?
i2c-mxs: fixed error message in pio transfer

If I2C_M_RD flag is set SELECT command is sent
and afterward READ command.
The patch fixes READ command to return READ failure error message
instead of SELECT failure error message.

>> Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
>> ---
>>    linux-3.14.17/drivers/i2c/busses/i2c-mxs.c | 2 +-
> btw. how did this 'linux-3.14.17' get in the path ?
I have some scripts in my repo and I forgot about longer patch.

best regards
Janusz

Subject: [PATCH] i2c-mxs: fixed error message in pio transfer

If I2C_M_RD flag is set SELECT command is sent
and afterward READ command.
The patch fixes READ command to return READ failure error message
instead of SELECT failure error message.

Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
---
  drivers/i2c/busses/i2c-mxs.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.=
c
index 0cde4e6..87ee72d 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -429,7 +429,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapte=
r=20
*adap,
                 ret =3D mxs_i2c_pio_wait_xfer_end(i2c);
                 if (ret) {
                         dev_err(i2c->dev,
-                               "PIO: Failed to send SELECT command!\n"=
);
+                               "PIO: Failed to send READ command!\n");
                         goto cleanup;
                 }

--
1.7.11.3
