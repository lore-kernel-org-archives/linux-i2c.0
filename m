From: jeremy.compostella@intel.com (Compostella, Jeremy)
Subject: Re: i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA
Date: Tue, 16 Jan 2018 12:42:12 -0700
Message-ID: <87k1whpp4b.fsf@jcompost-mobl.amr.corp.intel.com>
References: <871skzpbby.fsf@jcompost-mobl.amr.corp.intel.com>
        <20180115175906.4ezync7thrqvqjcu@ninjato>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:11330 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbeAPTmQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 16 Jan 2018 14:42:16 -0500
In-Reply-To: <20180115175906.4ezync7thrqvqjcu@ninjato> (Wolfram Sang's message
        of "Mon, 15 Jan 2018 18:59:06 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Wolfram,

> On Wed, Nov 15, 2017 at 12:54:09PM -0700, Compostella, Jeremy wrote:
> > On a I2C_SMBUS_I2C_BLOCK_DATA read request, if data->block[0] is
> > greater than I2C_SMBUS_BLOCK_MAX + 1, the underlying I2C driver writes
> greater or equal?
> > data out of the msgbuf1 boundary.
> > 
> > It is possible from a user application to run into that issue by call
> > the I2C_SMBUS ioctl with data.block[0] greater than
> > I2C_SMBUS_BLOCK_MAX + 1.
> ditto?

Actually, this is a bit more complicated.  Theoretically it should be
"greater than I2C_SMBUS_BLOCK_MAX". The documentation
(Documentation/i2c/dev-interface) says "The block buffers need not be
longer than 32 bytes".  However, in practice, The
i2c_smbus_xfer_emulated() function defines:

       unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];

It uses the first element to store the requested length.  Therefore,
in practice, we hit the issue with "greater than I2C_SMBUS_BLOCK_MAX +
1".

> Basically good, yet to make the code easier to read I'd suggest
> something like this? Untested, wanted to hear your opinion first.

>  drivers/i2c/i2c-core-smbus.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 4bb9927afd0106..5fc5ddd965434f 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -397,16 +397,16 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>  				   the underlying bus driver */
>  		break;
>  	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
> +			dev_err(&adapter->dev, "Invalid block size %d\n",
> +				data->block[0]);
> +			return -EINVAL;
> +		}
> +
>  		if (read_write == I2C_SMBUS_READ) {
>  			msg[1].len = data->block[0];
>  		} else {
>  			msg[0].len = data->block[0] + 1;
> -			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 1) {
> -				dev_err(&adapter->dev,
> -					"Invalid block write size %d\n",
> -					data->block[0]);
> -				return -EINVAL;
> -			}
>  			for (i = 1; i <= data->block[0]; i++)
>  				msgbuf0[i] = data->block[i];
>  		}

This is a better option, I think I have made such a version at some
points but did not want to touch the other case for some reasons that
I cannot remember now :/

I have a added a little c ternary instruction to keep the same level
of debug/error information.  If you don't like it we can remove it.

I have updated, tested and attached the new version to this email.  I
also improved the commit message by adding some information about what
is expected by the documentation. I don't know what is the process to
update the patch to the mailing list.  Should I send a new email with
the new patch instead ?

Thanks,

Jeremy

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-i2c-core-smbus-prevent-stack-corruption-on-read-I2C_.patch
Content-Description: [PATCH] i2c: core-smbus: prevent stack corruption on
 read I2C_BLOCK_DATA

>From 72c6683ac2e25304ec01e8fe2974abe744a129a0 Mon Sep 17 00:00:00 2001
From: Jeremy Compostella <jeremy.compostella@intel.com>
Date: Wed, 15 Nov 2017 12:31:44 -0700
Subject: [PATCH] i2c: core-smbus: prevent stack corruption on read
 I2C_BLOCK_DATA

On a I2C_SMBUS_I2C_BLOCK_DATA read request, if data->block[0] is
greater than I2C_SMBUS_BLOCK_MAX + 1, the underlying I2C driver writes
data out of the msgbuf1 array boundary.

It is possible from a user application to run into that issue by
calling the I2C_SMBUS ioctl with data.block[0] greater than
I2C_SMBUS_BLOCK_MAX + 1.

This patch makes the code compliant with
Documentation/i2c/dev-interface by raising an error when the requested
size is larger than 32 bytes.

Call Trace:
 [<ffffffff8139f695>] dump_stack+0x67/0x92
 [<ffffffff811802a4>] panic+0xc5/0x1eb
 [<ffffffff810ecb5f>] ? vprintk_default+0x1f/0x30
 [<ffffffff817456d3>] ? i2cdev_ioctl_smbus+0x303/0x320
 [<ffffffff8109a68b>] __stack_chk_fail+0x1b/0x20
 [<ffffffff817456d3>] i2cdev_ioctl_smbus+0x303/0x320
 [<ffffffff81745aed>] i2cdev_ioctl+0x4d/0x1e0
 [<ffffffff811f761a>] do_vfs_ioctl+0x2ba/0x490
 [<ffffffff81336e43>] ? security_file_ioctl+0x43/0x60
 [<ffffffff811f7869>] SyS_ioctl+0x79/0x90
 [<ffffffff81a22e97>] entry_SYSCALL_64_fastpath+0x12/0x6a

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
---
 drivers/i2c/i2c-core-smbus.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 10f00a8..e54a9b8 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -396,16 +396,17 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 				   the underlying bus driver */
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+			dev_err(&adapter->dev, "Invalid block %s size %d\n",
+				read_write == I2C_SMBUS_READ ? "read" : "write",
+				data->block[0]);
+			return -EINVAL;
+		}
+
 		if (read_write == I2C_SMBUS_READ) {
 			msg[1].len = data->block[0];
 		} else {
 			msg[0].len = data->block[0] + 1;
-			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 1) {
-				dev_err(&adapter->dev,
-					"Invalid block write size %d\n",
-					data->block[0]);
-				return -EINVAL;
-			}
 			for (i = 1; i <= data->block[0]; i++)
 				msgbuf0[i] = data->block[i];
 		}
-- 
2.9.4


--=-=-=--
