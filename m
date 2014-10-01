From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Proposal] PM sleep children of inactive I2C bus segments off Masters
 in multi-master systems
Date: Wed, 1 Oct 2014 11:34:40 -0700
Message-ID: <CAAVjN7dwS62EKMnuZc_P1UjkbRVk6RXqJ91GwWZ96bbY5Ct-rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Currently I2C mux devices that support multiple master arbitration are
the i2c-mux-pca9541 and i2c-arb-gpio-challenge drivers. I propose to
add the ability to configure an interrupt pin from the Master Selector
device to indicate that bus ownership has been lost. Once the device
loses ownership, all of its children should enter a pm sleep mode (as
you can't talk to them at this point) until master-ship has been
reacquired.

This has come up as an issue when the master loses control over a bus
the return code of all transactions to its lave devices is EIO (not
very helpful).

Any comments would be appreciated, I am just looking if there is
interest in this.

Thanks,

-- 
- Danielle Costantino
