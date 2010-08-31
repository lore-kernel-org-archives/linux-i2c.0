From: Sundar <sunder.svit@gmail.com>
Subject: Re: [PATCH 1/3] drivers: misc: ak8974 / ami305 magnetometer driver
Date: Tue, 31 Aug 2010 12:43:16 +0530
Message-ID: <AANLkTikd8pCCn6aYL610qcUAHWsj5zoU8UBJ1pf4ffe1@mail.gmail.com>
References: <1282910083-8629-1-git-send-email-samu.p.onkalo@nokia.com>
	<1282910083-8629-2-git-send-email-samu.p.onkalo@nokia.com>
	<AANLkTim=Zq7Pxixdwe_H-659cLZ2yybediDURGwvoO3=@mail.gmail.com>
	<1283152361.16404.22.camel@4fid08082>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283152361.16404.22.camel@4fid08082>
Sender: linux-kernel-owner@vger.kernel.org
To: samu.p.onkalo@nokia.com
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: linux-i2c@vger.kernel.org

Hi again,

On Mon, Aug 30, 2010 at 12:42 PM, Onkalo Samu <samu.p.onkalo@nokia.com> wrote:
>
> It would require some more operations since the chip would loose its
> state totally. But yes, it could be done.
>
Yes. Something like re-programming the context. but it would make sure that
the module draws no power at all.

Also, would it not be correct to include a cancel_work_sync in case of
return here?

+fail4:
+       misc_deregister(&chip->miscdev);
+fail3:
+       ak8974_regulators_off(chip);
+fail2:
+       regulator_bulk_free(ARRAY_SIZE(chip->regs), chip->regs);
+fail1:
+       kfree(chip);
+       return err;
+}

Cheers!
