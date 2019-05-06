From: Dreamcat4 <dreamcat4@gmail.com>
Subject: Re: [PATCH 2/2] eeprom: ee1004: Deal with nack on page selection
Date: Mon, 6 May 2019 15:30:26 +0100
Message-ID: <CAN39uTpQj=ebjhydX2LnukkMAS-_Qi-nBMsUCjE4J-B_4HN8LQ@mail.gmail.com>
References: <20190506151539.69ee75e8@endymion> <20190506151656.47494e56@endymion>
 <04843f27-bb0f-d631-32c8-80cd122b7399@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <04843f27-bb0f-d631-32c8-80cd122b7399@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-i2c@vger.kernel.org

Don't mind either way, please do as you see fit

On Mon, May 6, 2019 at 3:04 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 5/6/19 4:16 PM, Jean Delvare wrote:
> > Some EE1004 implementations will not properly ack page selection
> > commands. They still set the page correctly, so there is no actual
> > error. Deal with this case gracefully by checking the currently
> > selected page after we receive a nack. If the page is set right then
> > we can continue.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/misc/eeprom/ee1004.c |   12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> Does Dreamcat4 deserve reported and tested by tags here? I guess
> anonymous address is fine with those tags?
>
> (I re-tested these two patches on top of v5.1 and they make decode-dimms
> working on a machine with 2-4 * Crucial DD4 dimms)
>
> --
> Jarkko
