From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Date: Mon, 3 Dec 2018 14:50:15 -0600
Message-ID: <CAL_JsqJZJVMvd0aQJ8eDXBqiZ=quLrNGr3hhqePm8fCushHxxQ@mail.gmail.com>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com> <20181127125050.GO1107@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127125050.GO1107@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Peter Rosin <peda@axentia.se>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 27, 2018 at 6:50 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Nov 23, 2018 at 01:51:38PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The "at," prefix was never correct for Atmel, so fix the few occurrences
> > that got it wrong. Use "atmel," instead.
> >
> > While at it, remove the at,24c08 compatible string from the list of
> > trivial devices because it is already documented in eeprom/at24.txt.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>
> Peter, I'd assume you are okay with me applying the patch directly?

Didn't we agree that I take trivial devices changes? Normally, it
doesn't really matter, but I'll have to delay landing the json-schema
conversion because this will conflict.

Rob
