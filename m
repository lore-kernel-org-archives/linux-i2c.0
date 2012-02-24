From: Thomas Brandon <tbrandonau-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c multiplexer driver for Proliant microserver N36L
Date: Fri, 24 Feb 2012 18:56:07 +0000 (UTC)
Message-ID: <loom.20120215T165236-509@post.gmane.org>
References: <CAKdnbx7xeygkOK=BR+3vUrWT3GEt=PZrxgrEMvEB5nkOfAF0bg@mail.gmail.com> <20111127225514.GO19115@trinity.fluff.org> <CAKdnbx4u6+_WJjjMJ3jnDLSU8eJ0yXX0Mg-dcr=3F4FaOd2R=g@mail.gmail.com> <20111203162757.GA24302@ericsson.com> <CAKdnbx54R9t-mS9-EvyT-618wVp-YH0YDO++=m5t-JqR6h=GCw@mail.gmail.com> <20111203180819.2ddbcb3a@endymion.delvare> <CAKdnbx5V=qfa5dshRudHx+M3o8Eb6qJXCVG+ZBaBwCeKaoQYNA@mail.gmail.com> <20111206093906.21dccf8d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare <khali@...> writes:
> You don't need a multiplexer device at all. Please just have i2c-piix4
> driver register 4 i2c_adapter devices for the SB800. This would be a
> 3-step process:
> 
> 1* Turn piix4_adapter to an array, so that it can hold up to 4
>    i2c_adapter structures.
> 2* Add a mutex to prevent concurrent access to the register set. It
>    should be initialized in piix4_setup_sb800(), taken at the very
>    beginning of piix4_access() and released at the very end of this
>    function.
> 3* Add support for ports 1, 2 and 3 of the SB800.
> 
> This would ideally be 3 incremental patches to make testing and review
> easy. I can help with parts 1 and 2 if you want, as this can be tested
> without a SB800. But it should be fairly easy overall.
> 
I have reworked the original patch to (hopefully) fit the structure you suggest.
However I have encountered issues with it that I'm not sure how to solve. The
behaviour is the same under both the original and the modified version of the
patch. When running sensors-detect, SDA0 (i2c-0) and SDA2 (i2c-1) (SDA1 is
reserved for ASF devices and accessed through a seperate controller) scan fine
with the following (edited) output:
Next adapter: SMBus piix4 adapter (SDA0) (i2c-0)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x18
Probing for `Microchip MCP98243'...                         Success!
    (confidence 5, driver `jc42')
Client found at address 0x19
Probing for `Microchip MCP98243'...                         Success!
    (confidence 5, driver `jc42')
Client found at address 0x50
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Client found at address 0x51
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Next adapter: SMBus piix4 adapter (SDA2) (i2c-1)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x2f
Probing for `Nuvoton W83795G/ADG'...                        Success!
    (confidence 8, driver `w83795')

However while scanning SDA3 (i2c-2) sensors-detect finds a client at address
0x4c but no probes are successful and you get kernel output like:
i2c i2c-2: Transaction (pre): CNT=04, CMD=00, ADD=99, DAT0=ff, DAT1=01
i2c i2c-2: Transaction (post): CNT=04, CMD=00, ADD=99, DAT0=00, DAT1=01
i2c i2c-2: Transaction (pre): CNT=04, CMD=00, ADD=99, DAT0=00, DAT1=01
i2c i2c-2: Transaction (post): CNT=04, CMD=00, ADD=99, DAT0=00, DAT1=01
[SNIP]
i2c i2c-2: Transaction (pre): CNT=08, CMD=ac, ADD=99, DAT0=00, DAT1=01
i2c i2c-2: Transaction (post): CNT=08, CMD=ac, ADD=99, DAT0=00, DAT1=01
i2c i2c-2: Transaction (pre): CNT=0c, CMD=aa, ADD=99, DAT0=00, DAT1=01
i2c i2c-2: Transaction (pre): CNT=0c, CMD=aa, ADD=99, DAT0=00, DAT1=01
i2c i2c-2: SMBus Timeout!
i2c i2c-2: Bus collision! SMBus may be locked until next hard reset. (sorry!)
i2c i2c-2: Failed reset at end of transaction (01)
i2c i2c-2: Transaction (post): CNT=0c, CMD=aa, ADD=99, DAT0=00, DAT1=80

Then all subsequent access attempts before a hard reset result in output like:
i2c i2c-2: Transaction (pre): CNT=08, CMD=03, ADD=99, DAT0=00, DAT1=80
i2c i2c-2: SMBus busy (01). Resetting...
i2c i2c-2: Failed! (01)

Additionally, shutdown/restart commands now fail, as does using the power button
on the machine (it turns off but on powering back up the screen doesn't return).
The power cord must be removed before the server will restart. This is as
reported by the original submitter and another tester when the thread was posted
on the lm_sensors list
(http://lists.lm-sensors.org/pipermail/lm-sensors/2011-November/034259.html).
After restarting sensors now work as reported by others.

I'm not quite sure how best to proceed. Any tips on debugging/fixing this are
welcome.

Thomas Brandon
