From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Subject: i2c probing
Date: Sun, 21 Mar 2010 15:22:00 +0100
Message-ID: <4BA62B88.8080903@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Do you know why there is 2 methods of probing i2c [1] and [2], with different quirks for eeprom.
Why can't they be merged together ?


Thanks

Matthieu

PS : please keep me in CC


[1]
i2c_detect_address

    /* Make sure the address is valid */
    if (addr < 0x03 || addr > 0x77) {
        dev_warn(&adapter->dev, "Invalid probe address 0x%02x\n",
             addr);
        return -EINVAL;
    }

    /* Skip if already in use */
    if (i2c_check_addr(adapter, addr))
        return 0;

    /* Make sure there is something at this address */
    if (i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) < 0)
        return 0;

    /* Prevent 24RF08 corruption */
    if ((addr & ~0x0f) == 0x50)
        i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL);

[2]
i2c_new_probed_device
        if (addr_list[i] < 0x03 || addr_list[i] > 0x77) {
            dev_warn(&adap->dev, "Invalid 7-bit address "
                 "0x%02x\n", addr_list[i]);
            continue;
        }

        /* Check address availability */
        if (i2c_check_addr(adap, addr_list[i])) {
            dev_dbg(&adap->dev, "Address 0x%02x already in "
                "use, not probing\n", addr_list[i]);
            continue;
        }

        /* Test address responsiveness
           The default probe method is a quick write, but it is known
           to corrupt the 24RF08 EEPROMs due to a state machine bug,
           and could also irreversibly write-protect some EEPROMs, so
           for address ranges 0x30-0x37 and 0x50-0x5f, we use a byte
           read instead. Also, some bus drivers don't implement
           quick write, so we fallback to a byte read it that case
           too. */
        if ((addr_list[i] & ~0x07) == 0x30
         || (addr_list[i] & ~0x0f) == 0x50
         || !i2c_check_functionality(adap, I2C_FUNC_SMBUS_QUICK)) {
            union i2c_smbus_data data;

            if (i2c_smbus_xfer(adap, addr_list[i], 0,
                       I2C_SMBUS_READ, 0,
                       I2C_SMBUS_BYTE, &data) >= 0)
                break;
        } else {
            if (i2c_smbus_xfer(adap, addr_list[i], 0,
                       I2C_SMBUS_WRITE, 0,
                       I2C_SMBUS_QUICK, NULL) >= 0)
                break;
        }
