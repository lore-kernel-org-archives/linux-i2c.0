From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v2 2/2] MAX8997/8966 PMIC Regulator Driver Initial
 Release
Date: Tue, 8 Mar 2011 12:41:51 +0000
Message-ID: <20110308124151.GD20944@opensource.wolfsonmicro.com>
References: <1299221427-4726-1-git-send-email-myungjoo.ham@samsung.com>
 <1299221427-4726-3-git-send-email-myungjoo.ham@samsung.com>
 <20110305120302.GC30187@opensource.wolfsonmicro.com>
 <AANLkTik4cT3fbsCLFcsUcNMtia1Ymnhe8JFzzO+N+9sq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik4cT3fbsCLFcsUcNMtia1Ymnhe8JFzzO+N+9sq-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, MyungJoo Ham <myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 08, 2011 at 10:50:04AM +0900, MyungJoo Ham wrote:
> On Sat, Mar 5, 2011 at 9:03 PM, Mark Brown

> > This looks odd, especially since you have a disable operation?

> The intention is to keep it enabled if it was enabled before entering
> sleep and not to enable if it has not been using while the system is
> running. Probably, we need three states for suspend-prepare for
> regulators: disable, enable, keep_state?

No, that's not what the suspend mode settings are doing.  Many
regulators have separate state configuration for use when the system is
suspended, the purpose of suspend_prepare() is to configure that.  They
are orthogonal to the state seen when the system is running and it is
expected that the previously configured state will be automatically
recovered when exiting suspend.

The reason we set this stuff immediately before suspend is that Linux
has multiple suspend types so we need to adjust the configuration to
reflect the suspend type that's been chosen.
