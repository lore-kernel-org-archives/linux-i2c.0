From: jeremy.compostella@intel.com (Compostella, Jeremy)
Subject: Re: [PATCH] i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA
Date: Mon, 27 Nov 2017 12:14:22 -0700
Message-ID: <87mv37pm9d.fsf@jcompost-mobl.amr.corp.intel.com>
References: <871skzpbby.fsf@jcompost-mobl.amr.corp.intel.com>
        <20171127183847.ddatx2r5dnmrs3rl@ninjato>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:50815 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752516AbdK0TOX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 14:14:23 -0500
In-Reply-To: <20171127183847.ddatx2r5dnmrs3rl@ninjato> (Wolfram Sang's message
        of "Mon, 27 Nov 2017 19:38:47 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> On Wed, Nov 15, 2017 at 12:54:09PM -0700, Compostella, Jeremy wrote:
> > On a I2C_SMBUS_I2C_BLOCK_DATA read request, if data->block[0] is
> > greater than I2C_SMBUS_BLOCK_MAX + 1, the underlying I2C driver writes
> > data out of the msgbuf1 boundary.
> > 
> > It is possible from a user application to run into that issue by call
> > the I2C_SMBUS ioctl with data.block[0] greater than
> > I2C_SMBUS_BLOCK_MAX + 1.

> From Documentation/i2c/dev-interface:

> ioctl(file, I2C_SMBUS, struct i2c_smbus_ioctl_data *args)
>   Not meant to be called  directly; instead, use the access functions
>   below.
> Maybe we should add this info to the include file as well?
> But I guess we still shouldn't OOPS on this misuse...

I read that part of the documentation too.  But still, I really think
this is an issue as there should not exist a so easy to corrupt the
Kernel stack.

Thanks,

Jeremy
