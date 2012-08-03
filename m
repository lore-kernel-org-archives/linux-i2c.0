From: =?UTF-8?Q?Amaury_Decr=C3=AAme?= <amaury.decreme@gmail.com>
Subject: Re: [PATCH v2 0/2] I2C: SIS964: Bus driver
Date: Fri, 3 Aug 2012 18:36:36 +0200
Message-ID: <CAPXEm73QX7haU5p7HU+=+qo5wnivt6j+WH5bQGZ0ZK0Ek2Cuyw@mail.gmail.com>
References: <1344008145-14579-1-git-send-email-amaury.decreme@gmail.com> <20120803180712.1e768042@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20120803180712.1e768042@endymion.delvare>
Sender: linux-doc-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: ben-linux@fluff.org, w.sang@pengutronix.de, rob@landley.net, jeffrey.t.kirsher@intel.com, akpm@linux-foundation.org, davem@davemloft.net, gregkh@linuxfoundation.org, joe@perches.com, ralf@linux-mips.org, dirk.brandewie@gmail.com, jayachandranc@netlogicmicro.com, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>
> What is the rationale for not adding support for the new chip to
> i2c-sis630 then? That would probably be a lot easier to review.
>

I was afraid that adding SIS964 support to i2c-sis630 would lead
to confusion.

I can try to submit a patch for i2c-sis630. In this case, do you think
we should keep the 630 name or change it to something else to
avoid misunderstanding ?


>
> This split makes little sense. Integration should come with the drive=
r,
> otherwise even build-testing is impossible.
>

Sorry for that. As the patch V1 was rather big, I was hesitating for
the same reason but posted it split. I'll "unsplit" for the V3 (unless
i2c-sis630 patch).


Amaury Decr=C3=AAme
