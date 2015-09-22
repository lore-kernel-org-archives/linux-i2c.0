From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v4 0/3] I2C/SMBus: add support for Host Notify (in
 i2c_i801)
Date: Tue, 22 Sep 2015 13:41:27 -0400
Message-ID: <20150922174127.GH5089@mail.corp.redhat.com>
References: <1437677718-7894-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437677718-7894-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi All,

any estimate when anybody will be able to review this series?

Cheers,
Benjamin

On Jul 23 2015 or thereabouts, Benjamin Tissoires wrote:
> Hi,
> 
> this is the v4 of this patch series which fixes the race we discovered this
> week when accessing the registers in i2c_i801.
> 
> Compared to v3, i2c_handle_smbus_host_notify can now be called in a non sleeping
> thread because a worker will be spawn later on.
> That also means that we need to allocate the worker and some other structures,
> so I introduced i2c_setup_smbus_host_notify().
> 
> Cheers,
> Benjamin
> 
> 
> Benjamin Tissoires (3):
>   i2c: add a protocol parameter to the alert callback
>   i2c-smbus: add SMBus Host Notify support
>   i2c: i801: add support of Host Notify
> 
>  Documentation/i2c/smbus-protocol |   3 +
>  drivers/char/ipmi/ipmi_ssif.c    |   6 +-
>  drivers/hwmon/lm90.c             |   3 +-
>  drivers/i2c/busses/i2c-i801.c    | 164 +++++++++++++++++++++++++++++----------
>  drivers/i2c/i2c-smbus.c          | 113 +++++++++++++++++++++++++--
>  include/linux/i2c-smbus.h        |  43 ++++++++++
>  include/linux/i2c.h              |  10 ++-
>  include/uapi/linux/i2c.h         |   1 +
>  8 files changed, 292 insertions(+), 51 deletions(-)
> 
> -- 
> 2.4.3
> 
