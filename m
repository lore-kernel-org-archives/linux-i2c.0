From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mux: Remove unneeded platform_set_drvdata to NULL
 in remove
Date: Fri, 15 Feb 2013 20:53:48 +0100
Message-ID: <20130215195347.GF4351@the-dreams.de>
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
 <20130215193736.GD4351@the-dreams.de>
 <CAD=FV=VTJN3bU1rpMyjDMvX1SYZJWoJCiNtHNe+nDrtwnXqTXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=VTJN3bU1rpMyjDMvX1SYZJWoJCiNtHNe+nDrtwnXqTXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Peter Korsgaard <peter.korsgaard@barco.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


> I'll re-send with I2C subsystem wide.  I probably won't attempt the
> whole kernel wide at this point, but would be very happy if someone
> else wanted to!  :)

Thanks. Please double check that setting NULL is really unneeded for the
non-platform-bus variants, too, or skip those if you are unsure. Please
also update the commit message to reference a stronger indication than
Stephen's "should not be necessary" ;) I do agree but for the commit
history, a better reference would be nice to educate readers.

Thanks,

   Wolfram
