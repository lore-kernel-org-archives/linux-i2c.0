From: Rabin Vincent <rabin@rab.in>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Thu, 17 Feb 2011 20:55:06 +0530
Message-ID: <AANLkTikRUZRh0YnP8nYTKFnFeUiJbK5xKvHHjn_S+gZE@mail.gmail.com>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com> <201012170109.43137.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201012170109.43137.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: stern@rowland.harvard.edu, linux-pm@lists.linux-foundation.org, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, khilman@ti.com, magnus.damm@gmail.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Dec 17, 2010 at 05:39, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, December 16, 2010, Rabin Vincent wrote:
>> There seem to be some differences between the generic ops and the i2=
c
>> and platform busses' implementations of the interaction between runt=
ime
>> PM and system sleep:
>>
>> =A0 (1) The platform bus does not implement the
>> =A0 =A0 =A0 don't-call-pm->suspend()-if pm_runtime_suspended()-retur=
ns-true
>> =A0 =A0 =A0 functionality implemented by the generic ops and i2c.
>>
>> =A0 (2) Both I2C and platform do not set the device as active when a
>> =A0 =A0 =A0 pm->resume callback exists and it succeeds.
=2E..
>> Are these divergences from the generic ops to be considered as bugs?
>
> I think so. =A0I'm not sure about (1), because someone may already de=
pend on
> that behavior, but (2) looks like a bug to me.

Revisiting these points again.  (2) has since been corrected for i2c,
but platform does not do (1) and (2).

I've submitted a patch today to convert the AMBA bus to support pm-ops,
and it was convenient to just use the GENERIC_SUBSYS_PM_OPS.  But some
ARM SoCs have a combination of AMBA and platform devices for the on-chi=
p
devices so having different behaviour between the interaction of
runtime-pm and system suspend callbacks does not seem like an ideal
situation, and would only serve to confuse driver writers.  So, should =
I
just not use GENERIC_SUBSYS_PM_OPS in the AMBA bus but instead open-cod=
e
the rountines to make it work like platform?

This will solve the platform vs AMBA bus, but shouldn't we really be
aiming for consistent behaviour between these and the other busses such
as I2C and SPI, which are also usually commonly used on the same
platforms and are using GENERIC_PM_OPS?

Should we be auditing all platform drivers and then switch platform to
the GENERIC_PM_OPS?

Or should the two points (1) and (2) be not handled in the bus at all
and be left to individual drivers (in which case we should audit i2c an=
d
spi and change GENERIC_PM_OPS)?
