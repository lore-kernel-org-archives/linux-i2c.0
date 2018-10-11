From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v3 1/3] x86: baytrail/cherrytrail: Rework and move
 P-Unit PMIC bus semaphore code
Date: Thu, 11 Oct 2018 21:35:08 +0100
Message-ID: <20181011213508.40b8ce0e@alans-desktop>
References: <20181011142911.13750-1-hdegoede@redhat.com>
        <20181011142911.13750-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011142911.13750-2-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> 1) PMIC accesses often come in the form of a read-modify-write on one of
> the PMIC registers, we currently release the P-Unit's PMIC bus semaphore
> between the read and the write. If the P-Unit modifies the register during
> this window?, then we end up overwriting the P-Unit's changes.
> I believe that this is mostly an academic problem, but I'm not sure.

It should be.

> 2) To safely access the shared I2C bus, we need to do 3 things:
> a) Notify the GPU driver that we are starting a window in which it may not
> access the P-Unit, since the P-Unit seems to ignore the semaphore for
> explicit power-level requests made by the GPU driver

That's not what happens. It's more a problem of

We take the SEM
The GPU driver pokes the GPU
The GPU decides it wants to change the power situation
The GPU asks
It blocks on the SEM

and the system deadlocks.

> b) Make a pm_qos request to force all CPU cores out of C6/C7 since entering
> C6/C7 while we hold the semaphore hangs the SoC

Not just C6/C7 necessarily. We need to stop assorted transitions.

Given how horrible this lot was to debug originally do you have any
meaningful test data and performance numbers to justify it ? As an ahem
'feature' it's gone away in modern chips so is it worth the attention ?

Alan
