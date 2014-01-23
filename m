From: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 1/2] Create eeprom_dev hardware class for EEPROM devices
Date: Thu, 23 Jan 2014 06:54:34 -0800
Message-ID: <20140123145434.GG29955@cumulusnetworks.com>
References: <CAOMwXhNYtzsDDrLfp7AYT=YhewPqkJ841pPyKeNGVA9-quh6=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMwXhNYtzsDDrLfp7AYT=YhewPqkJ841pPyKeNGVA9-quh6=g@mail.gmail.com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laszlo Papp <lpapp-RoXCvvDuEio@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Thomas De Schampheleire <patrickdepinguin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Shrijeet Mukherjee <shm-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu Jan 23 07:34, Laszlo Papp wrote:
> On Thu, Jan 23, 2014 at 7:31 AM, Laszlo Papp <lpapp-RoXCvvDuEio@public.gmane.org> wrote:
> > On Wed, Jan 22, 2014 at 5:23 PM, Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org> wrote:
> >> Create a new hardware class under /sys/class/eeprom_dev
> >
> > I would also explain why it is called "eeprom_dev", and not "eeprom"
> > as it would naturally sound at first. I think you wrote this before on
> > the mailing list with your explanation, but it would be nice to record
> > it in the commit message as well for the posterity reading git log.

ACK, will put the reasoning in the git log.  The patch also adds the
reasoning in Documentation/misc-devices/eeprom_hw_class.txt

Cheers,
Curt
