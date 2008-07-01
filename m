From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] i2c pull request for s3c24xx driver
Date: Tue, 1 Jul 2008 16:11:27 +0200
Message-ID: <20080701161127.16724c11@hyperion.delvare>
References: <20080701133739.GA7933@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758949AbYGAOMd@vger.kernel.org>
In-Reply-To: <20080701133739.GA7933@fluff.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben-linu@fluff.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben, Linus,

On Tue, 1 Jul 2008 14:37:39 +0100, Ben Dooks wrote:
> Pull request for i2c driver fixes to the S3C24XX i2c driver
> suitable for applying to the current kernel.
> 
> Linus please take this unless Jean wants to pull this into
> his own i2c tree.

I'm totally fine with Linus pulling from your git tree directly.
That's less work for me, and you're the i2c subsystem co-maintainer
now. The whole point of you becoming a co-maintainer was that you could
offload some work from me.

> 
> The following changes since commit e1441b9a41c33aa9236008a7cfe49a8e723fb397:
>   Linus Torvalds (1):
>         Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input
> 
> are available in the git repository at:
> 
>   git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-fix
> 
> Ben Dooks (3):
>       I2C: S3C2410: Check ACK on byte transmission
>       I2C: S3C2410: Fixup error codes returned rom a transfer.
>       I2C: S3C2410: Add MODULE_ALIAS() for s3c2440 device.
> 
>  drivers/i2c/busses/i2c-s3c2410.c |   28 ++++++++++++++--------------
>  1 files changed, 14 insertions(+), 14 deletions(-)

Thanks,
-- 
Jean Delvare
