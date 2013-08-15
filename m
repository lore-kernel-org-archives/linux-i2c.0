From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] i2c: mxs: Better error handling
Date: Thu, 15 Aug 2013 13:09:41 +0200
Message-ID: <520CB6F5.1040309@free-electrons.com>
References: <1372841962-26310-1-git-send-email-alexandre.belloni@free-electrons.com> <20130815100331.GD2987@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130815100331.GD2987@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de
List-Id: linux-i2c@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Wolfram,

On 15/08/2013 12:03, Wolfram Sang wrote:
> On Wed, Jul 03, 2013 at 10:59:22AM +0200, Alexandre Belloni wrote:
>> This patch fixes two error handling cases in mxs_i2c_xfer_msg():
>>
>>  - in PIO mode, mxs_i2c_pio_setup_xfer() may return an error but
i2c->cmd_err
>>  will not be set so mxs_i2c_xfer_msg() fails silently.
>>
>>  - in DMA mode, mxs_i2c_dma_setup_xfer() may return an error and have
>>  i2c->cmd_err set to -ENXIO. In that case, we want to go through the
>>  MXS_I2C_CTRL1_CLR_GOT_A_NAK before returning.
>
> A short explanation why we want that would be perfect.
>
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>
> I'd like to postpone this until I applied Marek's PIO rework. Could you
> respin after that?
>

Actually, this patch won't be needed after Marek's PIO rework. You can
drop it now.

- -- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJSDLb1AAoJEKbNnwlvZCyzBOoQAL5NbGfmv2toVVcOHIkGpe0X
L+4NqviBObeP2Kh/JWPm8zfuLhIHTU+MNGxFpL5JLzGh+5NVqEA5M7bQjwxmZxPS
OCEgzKwMzrTbxM3mOAxALO3LtEOUa6xBzzcKbaeWq48m2yA2KRt9niEqvN+cAHVl
rqFyrcv54AUOfdMS923bBNqMpTdpCmdy164msFV+yQqljd4Igg0T54KqmHmw2+4m
asfJtDAa674sGizZdB0bSZTo0pGhD2TJEdqU17rsDa/PruFgI8/lw4LOXtpL017M
zwx7miO6gkUymEiyOtfufOBkEUSfPmOPd/BcasgAs8loo01IPttn2vMWAV+Pku+D
XzbvFvSrlHiMQze6GCejv3W5dMySyDMnWma5ZGJ9DXkzE677UK7i7ehZSxn4huVn
w5JNgXfCsOexjTRmtoUad652kQl/GKDL5DdJr75wcZzp/6RfyGz3fu4mfUYiqFue
vW/Xbkswc334v2ueuQsdzlEEFfGaiddlsyHHfEEOsdO7djoGRXBoUxI+S1bDFdLO
WXCLRO11Ju0IXiTQ9uBBSibP0nSmu9W6/s1Ufp1F3OWqAj+H7CEZpqjg4hQkMIh+
997svOMknIuJzLhvBQbGj8FJ1FQhNDRaF49tFrpBhZaXp3a+a1rS31kZaoTx2etT
35VZG9zLAOGkfCPU3JEu
=bjCC
-----END PGP SIGNATURE-----
