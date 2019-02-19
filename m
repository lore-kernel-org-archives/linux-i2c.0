From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] eeprom: at24: new property
Date: Tue, 19 Feb 2019 13:39:38 +0100
Message-ID: <20190219123938.GA4867@kroah.com>
References: <20190205135934.18841-1-brgl@bgdev.pl>
 <CAMRc=MdRgmOwcaytv83pOHGYGwsskCVx3gRqaatg8sMDShmnLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=MdRgmOwcaytv83pOHGYGwsskCVx3gRqaatg8sMDShmnLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 12, 2019 at 03:12:05PM +0100, Bartosz Golaszewski wrote:
> wt., 5 lut 2019 o 15:00 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Microchip 24aa02t EEPROM is compatible with Atmel 24c02 except that
> > it's visible on 8 i2c slave addresses. We already support such a
> > use case with hard-coded config for 'atmel,24c00'. Let's add a more
> > flexible device tree property - 'num-addresses' - to the binding
> > document and support it in the driver.
> >
> > Bartosz Golaszewski (2):
> >   dt-bindings: at24: add the 'num-addresses' property
> >   eeprom: at24: implement support for 'num-addresses' property
> >
> >  Documentation/devicetree/bindings/eeprom/at24.txt |  3 +++
> >  drivers/misc/eeprom/at24.c                        | 13 ++++++++-----
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> >
> > --
> > 2.20.1
> >
> 
> If there are no objections, I will apply these in 2 days and include
> them in the PR for v5.1.

No objections from me:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
