From: Jean Delvare <khali@linux-fr.org>
Subject: Re: qestion about I2C_CLASS_HWMON flag
Date: Thu, 4 Sep 2008 12:08:55 +0200
Message-ID: <20080904120855.7e7b9720@hyperion.delvare>
References: <38b2ab8a0809040043g7f944872l47f84c53bb213829@mail.gmail.com>
	<38b2ab8a0809040105j7ae3aca8xd334a4d203d9415b@mail.gmail.com>
	<20080904103707.557ac764@hyperion.delvare>
	<38b2ab8a0809040149u2bc0342h5c32b87f9277322f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756838AbYIDKJV@vger.kernel.org>
In-Reply-To: <38b2ab8a0809040149u2bc0342h5c32b87f9277322f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 4 Sep 2008 10:49:55 +0200, Francis Moreau wrote:
> On Thu, Sep 4, 2008 at 10:37 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > Hi Francis,
> >
> > On Thu, Sep 4, 2008 at 9:43 AM, Francis Moreau <francis.moro@gmail.com> wrote:
> >> I'm wondering why does this flag exist ?
> >>
> >> Why is a hw monitor device so special so that an I2C bus needs
> >> a flag to tell the rest of the world that it support it ?
> >
> > I don't understand your point. We have I2C_CLASS flags for many I2C
> > device types (analog TV, digital TV, etc.) I2C_CLASS_HWMON isn't the
> > exception you describe. Look at <linux/i2c.h> for a list of these flags.
> >
> 
> My question (sorry if that silly) is why do we need these flags at all ?
> 
> Can't I2C bus address any kinds of I2C devices ?

In general they can, yes (where they can't, it's due to restrictions in
protocol implementations, not device types.) But this isn't a matter of
what devices can be on the bus. This is a matter of what devices can be
probed for on a given bus. For example, hardware monitoring drivers
which handle I2C devices, make sure that I2C_CLASS_HWMON is set before
probing I2C addresses on a given bus in search of a device to
auto-detect. On the other hand, if they are merely attaching to an I2C
device which has already been instantiated (and thus no probing is
needed) they do not care about the class. The reason for this mechanism
is that probing can be risky, so we want to limit it to what is
strictly needed. For example, there is no point in probing the I2C bus
of a TV adapter for hardware monitoring chips - there simply can't be
any there. If there ever was any, that would be such a special case
that we would instantiate the I2C device in question explicitly from
the adapter code, so we have no need for probing.

The general idea is that the class value is about what devices can be
probed for, not what devices can be present. The field should probably
have been named "probe_class" instead of just "class", but back when it
was created, all I2C in the kernel was about probing so this precision
didn't seem needed. Things have changed since then. Maybe we'll rename
it at some point but I don't want to bother driver authors uselessly.

> What make hwmon devices special so that some I2C adapter can't
> talk to them ?

Again there's nothing special about hwmon. All device types are (or
should be) handled the same way.

-- 
Jean Delvare
