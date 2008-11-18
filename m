From: Jean Delvare <khali@linux-fr.org>
Subject: Re: #2361: i2c and lm_sensors do not work on Slackware 12.1 with
 kernel 2.6.27.6
Date: Tue, 18 Nov 2008 17:02:05 +0100
Message-ID: <20081118170205.2c48d793@hyperion.delvare>
References: <040.878a61a6a191c2ece367aefb3b3bc643@lm-sensors.org>
	<049.52c5d9ff015802332972920378e356e9@lm-sensors.org>
	<200811182017.43109.twinreverb@puresimplicity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200811182017.43109.twinreverb@puresimplicity.net>
Sender: linux-acpi-owner@vger.kernel.org
To: twinreverb@puresimplicity.net
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Robert,

On Tue, 18 Nov 2008 20:17:42 +0900, Robert Delahunt wrote:
> How is it fixed?  ACPI and sensors should be able to live together.

Playing the devil's advocate for a minute: why? ACPI and lm-sensors are
ways to achieve something, and at some level they are different ways to
achieve the same thing. Having both working together is not a goal per
se. The two real goals are: 1* let the user obtain information about
his/her hardware (temperature in particular) and 2* make sure we do not
crash the system. The former may be obtained without getting ACPI and
lm-sensors to work at the same time, and for the latter, ACPI and
lm-sensors generally must NOT be used at the same time.

Now, in practice ACPI is often getting way less out of the hardware than
lm-sensors would do and I definitely agree that this is frustrating.
But as responsible developers we have to first guarantee that the
user's system is safe, before looking at how to expose more features.

> (...) If I 
> can't have one without the other, in my opinion, this is a blind spot for 
> both projects.  Has anyone brought this up to the kernel ACPI developers to 
> see if they can "unhide" or "expose" the hardware monitoring?
> 
> As for this laptop, thermal regulating is actually controlled in the hardware: 
> neither ACPI nor sensors/i2c is needed to regulate temperature in the OS 
> level.  I just find it odd that i2c/lm_sensors claims to support this chipset 
> yet the answer I get is that the kernel ACPI "hides" them.

I'm not sure which chipset exactly you refer to? The Intel 82801DB is a
south bridge that doesn't include sensors. It includes an SMBus
controller, behind which hardware monitoring chips can live, but it is
disabled on your system. In most cases, this is an indication that ACPI
wants the SMBus for itself so we better don't access it. We would need
to look at the acpidump of this system to make sure.

Anyway, even if your laptop had a hardware monitoring chips which is
listed as supported by lm-sensors, but ACPI is using it, then you
shouldn't be using the "native" driver for it. Just because we claim to
support some device doesn't mean that loading the driver is the right
thing to do on all systems (I really would like it to be the case, it
would be much easier for everyone, but in the real world it isn't.)

> I'll bring this up to the kernel ACPI developers, but I would like to see this 
> issue resolved.  Again, I am willing to test out whatever code necessary to 
> help this process.

Wait for APCI v4 maybe? Fundamentally this is a design flaw of ACPI to
grab resources which the OS would also need without providing a way to
synchronize access.

-- 
Jean Delvare
