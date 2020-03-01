From: Stefan Schaeckeler <schaecsn@gmx.net>
Subject: Re: [PATCH 0/1] i2c: imc: Add support for Intel iMC SMBus host controller.
Date: Sun,  1 Mar 2020 11:02:10 -0800 (PST)
Message-ID: <20200301190210.BC7C96E85603@corona.crabdance.com>
References: <1582498270-50674-1-git-send-email-schaecsn@gmx.net> <CALCETrXcFrR9V_yjPRh9eJ1=1efo_DCCwGTeusmo2CQXpFFdrw@mail.gmail.com>
Reply-To: schaecsn@gmx.net
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CALCETrXcFrR9V_yjPRh9eJ1=1efo_DCCwGTeusmo2CQXpFFdrw@mail.gmail.com>
        (message from Andy Lutomirski on Tue, 25 Feb 2020 13:49:34 -0800)
Sender: linux-kernel-owner@vger.kernel.org
To: luto@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Any,

> > This patch is based on Andy Lutomirski's iMC SMBus driver patch-set
> > https://lkml.org/lkml/2016/4/28/926. It never made it into the kernel.=
 I hope
> > this rewrite will:
> >
> >
> > Overview
> >
> > Modern Intel memory controllers host an SMBus controller and connectio=
n to
> > DIMMs and their thermal sensors. The memory controller firmware has th=
ree modes
> > of operation: Closed Loop Thermal Throttling (CLTT), Open Loop Thermal
> > Throttling (OLTT) and none.
> >
> > - CLTT: The memory controller firmware is periodically accessing the D=
IMM
> >   temperature sensor over the SMBus.
> >
>
>
> I think this is great!  One question, though: what happens if the
> system is in CLTT mode but you disable CLTT and claim the bus for too
> long?  For example, if there's an infinite loop or other lockup which
> you have the tsod polling interval set to 0?  Does the system catch
> fire or does the system do something intelligent like temporarily
> switching to open loop?

I don't know. Most likely, the current memory throttling rate will be kept=
.
That might not be enough for the forthcoming workload and, ehm, the system=
 may
catch fire.

I assume our use-case is the most common use-case for this driver: our emb=
edded
system comes with its own environmental management software. It monitors, =
among
other sensor values, the DIMM temperatures and takes action on abnormal va=
lues.
If one is concerned about your scenario, then the environmental management
software needs to consider blocked reads on the sysfs node as a worst case
scenario and reboot the system.

Nothing can really go wrong while the polling interval is set to 0, though=
:

- reading and setting pci configuration space registers.
- calling dev_err, dev_warn and alike.
- usleep_range(131,140) and up to 20 udelay(9).

What is not clear to me is what if imc_smbus_xfer() is executing while the
driver is rmmod-ed. Defensively, I set in the driver's remove function the
tsod_polling_interval back to its original value.

~ Stefan
