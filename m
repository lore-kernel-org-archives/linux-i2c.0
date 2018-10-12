From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v3 1/3] x86: baytrail/cherrytrail: Rework and move
 P-Unit PMIC bus semaphore code
Date: Fri, 12 Oct 2018 18:08:21 +0100
Message-ID: <20181012180821.602abd04@alans-desktop>
References: <20181011142911.13750-1-hdegoede@redhat.com>
        <20181011142911.13750-2-hdegoede@redhat.com>
        <20181011213508.40b8ce0e@alans-desktop>
        <34244947-6b73-55c2-a0e8-b6a66050a612@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <34244947-6b73-55c2-a0e8-b6a66050a612@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> > It should be.  
> 
> You mean that the problem should be purely academic, IOW that registers touched
> by the P-Unit are never touched through ACPI Opregions / power-resources?

As far as I am aware. Holding the lock over both is definitely better
regardless

> >> 2) To safely access the shared I2C bus, we need to do 3 things:
> >> a) Notify the GPU driver that we are starting a window in which it may not
> >> access the P-Unit, since the P-Unit seems to ignore the semaphore for
> >> explicit power-level requests made by the GPU driver  
> > 
> > That's not what happens. It's more a problem of
> > 
> > We take the SEM
> > The GPU driver pokes the GPU
> > The GPU decides it wants to change the power situation
> > The GPU asks
> > It blocks on the SEM
> > 
> > and the system deadlocks.  
> 
> That may be, but why does it deadlock?

As I understand it because the CPU is stuck waiting for the GPU which is
waiting for the SEM which the CPU is holding. This isn't purely software
remember.

> I can understand that you are reluctant to change this code, but this
> commit is not changing the logic, it mostly just moves the code around
> and I do believe that overall doing this is worthwhile.

Fair enough

Alan
