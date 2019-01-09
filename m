From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH 0/8] Add IPROC I2C slave mode and NIC I2C support
Date: Wed, 9 Jan 2019 10:27:59 -0800
Message-ID: <44deeaef-a9b8-9ce1-d6b8-76d99a53cd4f@broadcom.com>
References: <1546938997-13798-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <6a5380e3-1e15-31e3-bbaa-134856a0c2dc@broadcom.com>
 <CAHO=5PG3NnYqoSyZ9u9kN1m7KagtKv275tpWj6s8NXvzhj52fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHO=5PG3NnYqoSyZ9u9kN1m7KagtKv275tpWj6s8NXvzhj52fQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Michael Cheng <ccheng@broadcom.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-i2c@vger.kernel.org

Okay. Just noticed another thing. May I ask if you ran the
'get_maintaimner.pl' script to figure out the 'To:' and 'Cc:'?

I don't see Wolfram's name on on the To or Cc field of the emails you
send out:

Wolfram Sang <wsa@the-dreams.de>

6845 I2C SUBSYSTEM
6846 M:      Wolfram Sang <wsa@the-dreams.de>
6847 L:      linux-i2c@vger.kernel.org


Thanks,

Ray

On 1/8/2019 6:15 PM, Rayagonda Kokatanur wrote:
> Sorry for confusion. I made mistake in adding bcm-kernel-feedback-list
> while sending patch. Hence sent same patch set with updated email list. 
> 
> Best regards,
> Rayagonda
> 
> 
> 
> On Jan 8, 2019 10:55 PM, "Ray Jui" <ray.jui@broadcom.com
> <mailto:ray.jui@broadcom.com>> wrote:
> 
>     You sent out the same patch series 3 times without any explanation. Very
>     confusing.
> 
>     Is this the latest one that should be reviewed?
> 
>     Thanks,
> 
>     Ray
> 
> 
>     On 1/8/2019 1:16 AM, Rayagonda Kokatanur wrote:
>     > Hi,
>     > This patchset contains support for IPROC I2C slave and NIC I2C
>     support.
>     > Following are the brief changes done inorder to support both IPROC I2C
>     > slave mode and NIC I2C,
>     >
>     > a. Add support to allow I2C rx transfer upto 255 bytes
>     > b. Add polling mode support to the iProc I2C driver. Polling mode
>     is used
>     >    in certain SoCs where interrupt is not connected from the I2C
>     block.
>     > c. Add warpper read/write access for register to support indirect
>     register
>     >    access. This is required in certain SoCs with this iProc I2C
>     >    block registered.
>     >
>     >
>     > Ray Jui (1):
>     >   dt-bindings: i2c: iproc: make 'interrupts' optional
>     >
>     > Rayagonda Kokatanur (5):
>     >   i2c: iproc: add polling support
>     >   i2c: iproc: use wrapper for read/write access
>     >   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>     >   i2c: iproc: add NIC I2C support
>     >   arm64: dts: Stingray: Add NIC i2c device node
>     >
>     > Shreesha Rajashekar (2):
>     >   i2c: iproc: I2C read up to 255 bytes support
>     >   i2c: iproc: Add Slave mode support
>     >
>     >  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  14 +-
>     >  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  18 +
>     >  drivers/i2c/busses/Kconfig                         |   1 +
>     >  drivers/i2c/busses/i2c-bcm-iproc.c                 | 767
>     +++++++++++++++++----
>     >  4 files changed, 669 insertions(+), 131 deletions(-)
>     >
> 
> 
