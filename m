From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
Date: Fri, 12 Oct 2018 11:23:06 +0200
Message-ID: <34244947-6b73-55c2-a0e8-b6a66050a612@redhat.com>
References: <20181011142911.13750-1-hdegoede@redhat.com>
 <20181011142911.13750-2-hdegoede@redhat.com>
 <20181011213508.40b8ce0e@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011213508.40b8ce0e@alans-desktop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 11-10-18 22:35, Alan Cox wrote:
>> 1) PMIC accesses often come in the form of a read-modify-write on one of
>> the PMIC registers, we currently release the P-Unit's PMIC bus semaphore
>> between the read and the write. If the P-Unit modifies the register during
>> this window?, then we end up overwriting the P-Unit's changes.
>> I believe that this is mostly an academic problem, but I'm not sure.
> 
> It should be.

You mean that the problem should be purely academic, IOW that registers touched
by the P-Unit are never touched through ACPI Opregions / power-resources?

>> 2) To safely access the shared I2C bus, we need to do 3 things:
>> a) Notify the GPU driver that we are starting a window in which it may not
>> access the P-Unit, since the P-Unit seems to ignore the semaphore for
>> explicit power-level requests made by the GPU driver
> 
> That's not what happens. It's more a problem of
> 
> We take the SEM
> The GPU driver pokes the GPU
> The GPU decides it wants to change the power situation
> The GPU asks
> It blocks on the SEM
> 
> and the system deadlocks.

That may be, but why does it deadlock? It should just wait for the I2C transfer
to finish, the GPU driver does wait for the P-Unit to report back that
it has done its job, IIRC it even has a timeout on the wait, yet we
get a consistent freeze. While nothing should stop the I2C transfer to
simply complete at this point, release the semaphore and everything then
can continue normally.

>> b) Make a pm_qos request to force all CPU cores out of C6/C7 since entering
>> C6/C7 while we hold the semaphore hangs the SoC
> 
> Not just C6/C7 necessarily. We need to stop assorted transitions.

Could be, it may be that the pm_qos request results in the CPU never
leaving C0. The code for this originally comes from the Android-x86 kernel patchset:

https://github.com/01org/ProductionKernelQuilts/tree/master/uefi/cht-m1stable/patches

and IIRC the commit there talks about avoiding C6 and C7.

> Given how horrible this lot was to debug originally do you have any
> meaningful test data and performance numbers to justify it ?

No, my mean reason for re-visiting this (I wrote most of the original code
to deal with this) was that I thought I was seeing a case where the
AML was modifying a PMIC register which was also being touched by the
P-Unit.

Eventually I figured out I was not actually seeing this, but then the
patch was already written.

> As an ahem
> 'feature' it's gone away in modern chips so is it worth the attention ?

I know and good riddance. But Cherry Trail SoCs with AXP288 PMICs are
still very common and are being sold 10000 at a time by Endless with
Linux pre-installed.

This change mostly just moves a bunch of code around, the only new
feature is the ability to nest calls to the iosf_mbi_block_punit_i2c_access()
function and not deadlock then.

This does result in a nice cleanup in the form of putting all the code
dealing with this together in arch/x86/platform/intel/iosf_mbi.c instead
of having it split over iosf_mbi.c and i2c-designware code.

And this will allow making the AXP288 fuel-gauge driver do all the steps
to claim the i2c-bus once before reading multiple registers to get the
battery status, something which has been on my TODO list for a while,
since as mentioned taking all these steps together is not cheap, esp.
if you also take into account all the work the GPU driver does when
notified that it will be unable to access the P-Unit for a while and
currently we do all the setup and teardown like 5 times or so just to
get the battery status once.

But sorry no numbers, it is sort of hard to measure this and I do think
that the impact will not be that big since the battery status is not
checked that often. Which is also why I've not spend time on this so
far.

I can understand that you are reluctant to change this code, but this
commit is not changing the logic, it mostly just moves the code around
and I do believe that overall doing this is worthwhile.

Regards,

Hans

p.s.

There also is this infamous bug which we really really need to fix:
https://bugzilla.kernel.org/show_bug.cgi?id=109051

But mostly (only?) seems to happen on systems with a Crystal Cove
PMIC where the I2C bus is not shared.

I know that some work was being done on this recently what is the
status of this?
