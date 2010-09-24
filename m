From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [BUG 2.6.36-rc5] of_i2c.ko <-> i2c-core.ko dependency loop
Date: Fri, 24 Sep 2010 16:14:44 -0600
Message-ID: <AANLkTikS8RSycQL4_Qn7EKuV=K0_Yx_VEojrx+oz5R4a@mail.gmail.com>
References: <19611.16302.262307.129176@pilspetsen.it.uu.se>
 <20100923113807.4643fbbb.rdunlap@xenotime.net> <19611.46496.782340.466509@pilspetsen.it.uu.se>
 <20100923150559.9c67da11.rdunlap@xenotime.net> <20100924111209.3c071da3@endymion.delvare>
 <19612.33369.175358.879889@pilspetsen.it.uu.se> <20100924133932.4320b993@endymion.delvare>
 <f1f37e21-f04a-4fef-868c-27c7d2ebe594@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f1f37e21-f04a-4fef-868c-27c7d2ebe594@email.android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Mikael Pettersson <mikpe@it.uu.se>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 24, 2010 at 7:48 AM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
>
>
> "Jean Delvare" <khali@linux-fr.org> wrote:
>
>>Hi Mikael,
>>
>>On Fri, 24 Sep 2010 12:50:01 +0200, Mikael Pettersson wrote:
>>> Jean Delvare writes:
>>> =A0> As far as I can see this is caused by this commit from Grant:
>>> =A0>
>>> =A0> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6=
=2Egit;a=3Dcommitdiff;h=3D959e85f7751c33d1a2dabc5cc3fe2ed0db7052e5
>>> =A0>
>>> =A0> Mikael, can you please try reverting this patch and see if it =
solves
>>> =A0> your problem?
>>>
>>> Yes, reverting the above commit from 2.6.36-rc5 eliminated the warn=
ings,
>>> and I was able to insmod the i2c-{core,dev,powermac}.ko modules.
>>
>>Thanks for testing and reporting. Grant, unless you come up with a fi=
x
>>very quickly, I'll have to revert
>>959e85f7751c33d1a2dabc5cc3fe2ed0db7052e5 for 2.6.36.
>
> I'll get a fix out today.

I've got two different fixes that I'm about to send you.  You can
choose the fix that you prefer.  The first option moves the offending
function into i2c-core.c.  The function parses the device tree data
and creates i2c_device for each i2c device node that it finds.  This
is analogous to i2c_scan_static_board_info().

The second options reverts most of the 959e85f7 commit, but keeps the
line that allows of-style matching is retained so that all i2c_devices
on powerpc machines will still bind correctly.

My preferred solution is the first option because the tested code path
does not changed.  The offending function is simply moved verbatim.
The second option is a smaller patch, but I can only test one of the
affected drivers.  However, I'll let you make the decision.

Both have been build tested on PowerPC and ARM, and run tested on a
PowerPC MPC5200 board.

patches to follow in a few minutes..

g.
