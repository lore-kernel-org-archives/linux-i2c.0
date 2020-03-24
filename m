From: Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: A bit confused on i2c communication between modules
Date: Tue, 24 Mar 2020 12:30:33 +0100
Message-ID: <20200324123033.5538c38d@coco.lan>
References: <55204992-9060-6008-31c7-c2855f712e70@gmail.com>
        <20200324082236.2c4d2ae4@coco.lan>
        <bc91be3d-802c-a58c-bd27-740e15516180@ideasonboard.com>
        <20200324095810.GC1134@ninjato>
        <63742e62-d0b6-9d7a-b491-d7969f8ea7e2@ideasonboard.com>
        <20200324102704.GD1134@ninjato>
        <7d82a76f-5165-5e7c-bcde-552f527da0d2@ideasonboard.com>
        <20200324110122.GG1134@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20200324110122.GG1134@ninjato>
Sender: linux-media-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, sean@mess.org, Shuah Khan <skhan@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Em Tue, 24 Mar 2020 12:01:22 +0100
Wolfram Sang <wsa@the-dreams.de> escreveu:

> On Tue, Mar 24, 2020 at 10:49:55AM +0000, Kieran Bingham wrote:
> > +cc: linux-i2c@vger.kernel.org
> > Moving /this/ to the linux-i2c list ;-)
> > 
> > Thanks Wolfram,
> > 
> > On 24/03/2020 10:27, Wolfram Sang wrote:  
> > >   
> > >> Maybe we should have a whole virtual I2C bus for virtual devices :-)
> > >>
> > >> (Hrm, that started out as a joke, and now I'm not sure if it's a real
> > >> option or not...)  
> > > 
> > > Just one final thought: I think this is actually the best option. Zero
> > > chance of address collisions (which could happen if you have a not
> > > perfectly-described real HW bus). No RPM mangling of real and virtual
> > > devices. A clear seperation what is real and what is virtual. Plus, you
> > > can implement it right away, no need to wait for the dynamic address
> > > assignment.  
> > 
> > Agreed - even better all round! But I presume we don't yet have a
> > 'virtual' i2c bus? So it's a patch-set to do first? Or is it already
> > feasible?  
> 
> From what I understand, you won't need an API for that. What I
> understand:
> 
> There will be a master device (a DVB or something). This will register
> its own i2c_adapter with a dummy .xfer callback. The sub-devices will be
> i2c_clients, then. 

Yes. That's what the current drivers that have integrated hardware
at the same silicon (like rtl28xx) do: their .xfer callback splits the
I2C addresses reserved for "internal" devices, and use a different set
of registers to handle those, instead of the normal ones used to
communicate with a real I2C hardware.

The cx231xx uses a different strategy: it has multiple I2C buses, being
one of them reserved for its own integrated I2C like bus.

> I don't know how you want communication between
> those. Maybe the .xfer callback will need to do some message parsing?
> 



Thanks,
Mauro
