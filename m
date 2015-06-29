From: "Matwey V. Kornilov" <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-tools: Implement Module.mk for eepromer subdir
Date: Mon, 29 Jun 2015 12:09:00 +0300
Message-ID: <CAJs94EYDu-yn9JG6FvXB+etYvH9N_JxS0z_0AYH_J=HgOo4a+w@mail.gmail.com>
References: <1435394947-5228-1-git-send-email-matwey.kornilov@gmail.com> <20150629104117.5c3d632a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150629104117.5c3d632a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nikola Pajkovsky <npajkovs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2015-06-29 11:41 GMT+03:00 Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>:
> Hi Matwey,
>
> On Sat, 27 Jun 2015 11:49:07 +0300, Matwey V. Kornilov wrote:
>> eepromer/Module.mk has to be present in order to do
>>     make EXTRA=eepromer
>
> The problem with the eepromer directory is that it's a mess. There are
> 3 tools there which do basically the same (programming EEPROMs), but
> each has its own limitations:
>  * eeprom can't deal with 16-bit addressed EEPROMs nor SMBus-only
>    controllers.
>  * eepromer can't deal with 8-bit addressed EEPROMs nor SMBus-only
>    controllers.
>  * eeprog only uses SMBus byte/word reads and writes, it lacks support
>    for raw I2C block writes so it is slow on large EEPROMs.
>
> On top of that, eeprom and eepromer build with a lot of warnings.
>
> I really don't want to maintain 3 different tools with the same
> purpose. eeprog seems to be the most promising of all 3, as it is fully
> functional, but I don't feel comfortable dropping the other 2 until
> block write support is added to eeprog.
>
> Would you be interested in adding block write support to eeprog? It has
> been on my to-do list for a long time but I could never find the time
> to actually look into it. I do not use these tools myself so my
> personal interest is low and this is why it never makes it to the top
> of my to-do list.

So am I.
I wanted to program EEPROM on my BeagleBone and I've found that eeprog
was missed in openSUSE packages. So,now I just want to simplify
packaging eeprog somehow in acceptable manner.

>
>> Signed-off-by: Matwey V. Kornilov <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>> --- /dev/null
>> +++ i2c-tools-3.1.1/eepromer/Module.mk
>> @@ -0,0 +1,79 @@
>> +# eepromer
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +
>> +EEPROMER_DIR := eepromer
>> +
>> +EEPROMER_CFLAGS := -O2 -Iinclude -Wall
>> +ifeq ($(USE_STATIC_LIB),1)
>> +EEPROMER_LDFLAGS     := $(LIB_DIR)/$(LIB_STLIBNAME)
>> +else
>> +EEPROMER_LDFLAGS     := -L$(LIB_DIR) -li2c
>> +endif
>
> This will link eepromer and eeprom with libi2c even though they don't
> need it, right?
>
>> +
>> +EEPROMER_TARGETS     := eepromer eeprom eeprog
>> +
>> +#
>> +# Programs
>> +#
>> +
>> +$(EEPROMER_DIR)/eepromer:  $(EEPROMER_DIR)/eepromer.o
>> +     $(CC) $(LDFLAGS) -o $@ $^ $(EEPROMER_LDFLAGS)
>> +
>> +$(EEPROMER_DIR)/eeprom: $(EEPROMER_DIR)/eeprom.o
>> +     $(CC) $(LDFLAGS) -o $@ $^ $(EEPROMER_LDFLAGS)
>> +
>> +$(EEPROMER_DIR)/eeprog: $(EEPROMER_DIR)/eeprog.o $(EEPROMER_DIR)/24cXX.o
>> +     $(CC) $(LDFLAGS) -o $@ $^ $(EEPROMER_LDFLAGS)
>> +
>> +#
>> +# Objects
>> +#
>> +
>> +$(EEPROMER_DIR)/eepromer.o: $(EEPROMER_DIR)/eepromer.c
>> +     $(CC) $(CFLAGS) $(EEPROMER_CFLAGS) -c $< -o $@
>> +
>> +$(EEPROMER_DIR)/eeprom.o: $(EEPROMER_DIR)/eeprom.c
>> +     $(CC) $(CFLAGS) $(EEPROMER_CFLAGS) -c $< -o $@
>> +
>> +$(EEPROMER_DIR)/eeprog.o: $(EEPROMER_DIR)/eeprog.c $(EEPROMER_DIR)/24cXX.h
>> +     $(CC) $(CFLAGS) $(EEPROMER_CFLAGS) -c $< -o $@
>> +
>> +$(EEPROMER_DIR)/24cXX.o: $(EEPROMER_DIR)/24cXX.c $(EEPROMER_DIR)/24cXX.h
>
> Also depends on $(INCLUDE_DIR)/i2c/smbus.h.
>
>> +     $(CC) $(CFLAGS) $(EEPROMER_CFLAGS) -c $< -o $@
>> +
>> +#
>> +# Commands
>> +#
>> +
>> +all-eepromer: $(addprefix $(EEPROMER_DIR)/,$(EEPROMER_TARGETS))
>> +
>> +strip-eepromer: $(addprefix $(EEPROMER_DIR)/,$(EEPROMER_TARGETS))
>> +     strip $(addprefix $(EEPROMER_DIR)/,$(EEPROMER_TARGETS))
>> +
>> +clean-eepromer:
>> +     $(RM) $(addprefix $(EEPROMER_DIR)/,*.o $(EEPROMER_TARGETS))
>> +
>> +install-eepromer: $(addprefix $(EEPROMER_DIR)/,$(EEPROMER_TARGETS))
>> +     $(INSTALL_DIR) $(DESTDIR)$(sbindir) $(DESTDIR)$(man8dir)
>> +     for program in $(EEPROMER_TARGETS) ; do \
>> +     $(INSTALL_PROGRAM) $(EEPROMER_DIR)/$$program $(DESTDIR)$(sbindir) ; \
>> +     $(INSTALL_DATA) $(EEPROMER_DIR)/$$program.8 $(DESTDIR)$(man8dir) ; done
>> +
>> +uninstall-eepromer:
>> +     for program in $(EEPROMER_TARGETS) ; do \
>> +     $(RM) $(DESTDIR)$(sbindir)/$$program ; \
>> +     $(RM) $(DESTDIR)$(man8dir)/$$program.8 ; done
>> +
>> +all: all-eepromer
>> +
>> +strip: strip-eepromer
>> +
>> +clean: clean-eepromer
>> +
>> +install: install-eepromer
>> +
>> +uninstall: uninstall-eepromer
>
> I don't think it makes sense to integrate eeprom and eepromer in the
> main build system if the plan is to get rid of them. I'd rather only
> integrate eeprog, so that distributions ship only that and everybody
> uses only that.
>
> Maybe eeprog should be moved to its own directory, and that new
> directory would be integrated into the build system while the rest of
> the eepromer directory would be left alone (and ultimately deleted.)

It is fine for me too.

>
> --
> Jean Delvare
> SUSE L3 Support



-- 
With best regards,
Matwey V. Kornilov
http://blog.matwey.name
xmpp://0x2207-962d5TIgE1qHXe+LvDLADg@public.gmane.org
