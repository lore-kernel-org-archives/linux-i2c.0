From: "Michael Krufky" <mkrufky@linuxtv.org>
Subject: Re: Problem with restricted I2C algorithms in kernel 2.6.26!
Date: Thu, 7 Aug 2008 15:03:36 -0400
Message-ID: <37219a840808071203y36775d8fx5cccd653da04e1fc@mail.gmail.com>
References: <5ab239b10807161233i6c1c4d0we01ea1b8e6ccaa5b@mail.gmail.com>
	 <20080807131357.59399ddf@hyperion.delvare>
	 <20080807183944.GA29207@uranus.ravnborg.org>
	 <20080807204900.1c077376@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756032AbYHGTDs@vger.kernel.org>
In-Reply-To: <20080807204900.1c077376@hyperion.delvare>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, "D. Kelly" <user.kernel@gmail.com>, "mailing list: linux-kernel" <linux-kernel@vger.kernel.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 7, 2008 at 2:49 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Thu, 7 Aug 2008 20:39:44 +0200, Sam Ravnborg wrote:
>> >
>> > Alternatively, I am curious if our build system couldn't allow 3rd
>> > party drivers to select in-tree modules. Obviously this would require
>> > the complete kernel source tree to be available, instead of just the
>> > header and config files as is usually the case. Sam, is this possible
>> > to do that at this time? If not, is this something that could be
>> > implemented, or is this too much work for the thin benefit?
>>
>> In general I recommnd to have the full kernel source available
>> simply because we have no in-kernel solution to create the required
>> set of files to build external modules.
>>
>> And today there is no way to hook into the kernel configuration
>> for an external module. First of we cannot allow changes in
>> the build kernel module as this would destroy module versioning
>> for instance.
>>
>> And in this case you ask because you would change the kernel
>> configuration.
>>
>> And I fail to see why this stuff cannot be done inside the
>> kernel source tree. Merging new kernel updates should be absolutely
>> trivial and then the drivers are better prepared for upstream anyway.
>
> OK, thanks for the clarification.
>
> Maybe one way would be for the external module build system to copy (or
> link to) the missing driver source from the kernel tree and build it
> locally with the rest of the external drivers, if it wasn't enabled in
> the original kernel configuration and they need it. That's probably
> just a couple lines of shell script, should be pretty easy. Obviously
> this only works for kernel options which only select a given driver and
> have no side effect on the rest of the kernel. And this is more
> user-friendly than having the user check its kernel configuration and
> rebuild his/her kernel.
>
> Just a thought anyway...
>
> --
> Jean Delvare

I agree with Trent and D.Kelly

These options should be made available to the user -- We should go
with the patch that Jean posted, "Subject: i2c: Let users select
algorithm drivers manually again" -- this is a fair compromise for
both sides -- users that dont know should leave the automatic
selection enabled.  Users that know better can disable the automatic
selection and enable what they need.

The statement, "just have the external driver merged into the kernel"
is not a solution.

Removing the option to build those additional algos is a regression, IMHO

Regards,

Mike Krufky
