From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [GIT PULL] i2c updates for 2.6.25
Date: Mon, 28 Jan 2008 10:43:48 +0100
Message-ID: <20080128104348.0f6925f6@hyperion.delvare>
References: <20080127182741.62bfe92a@hyperion.delvare>
	<9e4733910801270936q7affdee3o3518c2265acaf61d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759984AbYA1JoD@vger.kernel.org>
In-Reply-To: <9e4733910801270936q7affdee3o3518c2265acaf61d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux I2C <i2c@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Sun, 27 Jan 2008 12:36:03 -0500, Jon Smirl wrote:
> On 1/27/08, Jean Delvare <khali@linux-fr.org> wrote:
> > Linus,
> >
> > Please pull the i2c subsystem updates for Linux 2.6.25 from:
> >
> > git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus
> 
> The support for modalias loading of i2c modules isn't in here, what's
> the status?

The status is that I want to give people some time to comment on my
modalias patches before I merge them. I also didn't have the time to
look into the latest patches you sent yet, and I'd rather merge
everything at once. So the merge window for this is rather 2.6.26.

-- 
Jean Delvare
