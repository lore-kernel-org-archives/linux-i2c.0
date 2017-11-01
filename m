From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] at24: support eeproms that do not roll over page reads.
Date: Wed, 1 Nov 2017 14:22:15 +0800
Message-ID: <201711011406.dHjS3NBX%fengguang.wu@intel.com>
References: <1509378506-30851-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1509378506-30851-1-git-send-email-svendev-fuHqz3Nb1YI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, svendev-fuHqz3Nb1YI@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sven,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.14-rc7]
[cannot apply to next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sven-Van-Asbroeck/at24-support-eeproms-that-do-not-roll-over-page-reads/20171101-114231
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +210 drivers/misc/eeprom/at24.c

   185	
   186	/*
   187	 * This routine supports chips which consume multiple I2C addresses. It
   188	 * computes the addressing information to be used for a given r/w request.
   189	 * Assumes that sanity checks for offset happened at sysfs-layer.
   190	 *
   191	 * Slave address and byte offset derive from the offset. Always
   192	 * set the byte address; on a multi-master board, another master
   193	 * may have changed the chip's "current" address pointer.
   194	 *
   195	 * In case of chips that don't rollover page reads, truncate the count
   196	 * to the nearest page boundary. This might result in the
   197	 * at24_eeprom_read_XXX functions reading fewer bytes than requested,
   198	 * but this is compensated for in at24_read().
   199	 */
   200	static struct i2c_client *at24_translate_offset(struct at24_data *at24,
   201			unsigned int *offset, size_t *count)
   202	{
   203		unsigned int i, bits, remainder;
   204	
   205		bits = (at24->chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
   206		i = *offset >> bits;
   207		*offset &= AT24_BITMASK(bits);
   208		if ((at24->chip.flags & AT24_FLAG_NO_RDROL) && count) {
   209			remainder = BIT(bits) - *offset;
 > 210			*count = min(*count, remainder);
   211		}
   212	
   213		return at24->client[i];
   214	}
   215	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
