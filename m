From: Robert Delahunt <twinreverb@puresimplicity.net>
Subject: Re: [lm-sensors] #2361: i2c and lm_sensors do not work on Slackware 12.1 with kernel 2.6.27.6
Date: Tue, 18 Nov 2008 20:17:42 +0900
Message-ID: <200811182017.43109.twinreverb@puresimplicity.net>
References: <040.878a61a6a191c2ece367aefb3b3bc643@lm-sensors.org> <049.52c5d9ff015802332972920378e356e9@lm-sensors.org>
Reply-To: twinreverb@puresimplicity.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <049.52c5d9ff015802332972920378e356e9@lm-sensors.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

How is it fixed?  ACPI and sensors should be able to live together.  If I 
can't have one without the other, in my opinion, this is a blind spot for 
both projects.  Has anyone brought this up to the kernel ACPI developers to 
see if they can "unhide" or "expose" the hardware monitoring?

As for this laptop, thermal regulating is actually controlled in the hardware: 
neither ACPI nor sensors/i2c is needed to regulate temperature in the OS 
level.  I just find it odd that i2c/lm_sensors claims to support this chipset 
yet the answer I get is that the kernel ACPI "hides" them.

I'll bring this up to the kernel ACPI developers, but I would like to see this 
issue resolved.  Again, I am willing to test out whatever code necessary to 
help this process.

On Tuesday 18 November 2008 06:20:48 pm lm-sensors wrote:
> #2361: i2c and lm_sensors do not work on Slackware 12.1 with kernel
> 2.6.27.6
> ----------------------+----------------------------------------------------
>- Reporter:  ticket   |       Owner:  somebody
>       Type:  defect   |      Status:  closed
>   Priority:  major    |   Milestone:
>  Component:  sensors  |     Version:  3.0.3
> Resolution:  fixed    |    Keywords:
> ----------------------+----------------------------------------------------
>- Changes (by khali):
>
>  * cc: twinreverb@puresimplicity.net. (added)
>   * status:  new => closed
>   * resolution:  => fixed
>   * milestone:  3.0.4 =>
>
> Comment:
>
>  I don't see anything wrong here. Most laptops do not have (exposed)
>  hardware monitoring chips. Thermal regulation is handled by ACPI.



-- 
Very respectfully,
Robert Delahunt
-------------------------------------------------------------------
Ezekiel 11:19 New King James Version
Then I will give them one heart, and I will put a new spirit within
them, and take the stony heart out of their flesh, and give them a
heart of flesh....
