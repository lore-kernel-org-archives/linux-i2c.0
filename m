From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/3] i2c: convert SMBus alert setup function to return
 an ERRPTR
Date: Sat, 15 Feb 2020 07:20:20 +0100
Message-ID: <20200215072020.75b1b772@endymion>
References: <20200210172929.6001-1-wsa+renesas@sang-engineering.com>
        <20200210172929.6001-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200210172929.6001-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa@the-dreams.de>, Robert Richter <rrichter@marvell.com>, George Cherian <gcherian@marvell.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 10 Feb 2020 18:29:25 +0100, Wolfram Sang wrote:
> Only few drivers use this call, so drivers and I2C core are converted at
> once with this patch. By simply using i2c_new_client_device() instead of
> i2c_new_device(), we easily can return an ERRPTR for this function as
> well. To make out of tree users aware that something changed, the
> function is renamed to i2c_install_smbus_alert().

I wouldn't bother renaming the function. Chances that there actually
are out-of-tree users of this function are pretty small, and if that is
the case, they can adjust their code easily in a way that is still
compatible with old kernels.

-- 
Jean Delvare
SUSE L3 Support
