From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL
 boiler-plate
Date: Mon, 19 Mar 2018 13:51:42 +0100
Message-ID: <2c828644-8797-2ec7-fbd7-a6ef21fa1356@axentia.se>
References: <20180319091721.18193-1-brgl@bgdev.pl>
 <20180319091721.18193-5-brgl@bgdev.pl>
 <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se>
 <CAMRc=MdwmCr+OW-_DgKretCmTHc9oukODwN+Mw6FcaUuSD9nCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MdwmCr+OW-_DgKretCmTHc9oukODwN+Mw6FcaUuSD9nCg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2018-03-19 13:12, Bartosz Golaszewski wrote:
> 2018-03-19 12:03 GMT+01:00 Peter Rosin <peda@axentia.se>:
>> Also, use a // style comment for the SPDX line in C files.
> 
> I'm seeing both /* */ and // style comments used for SPDX headers - is
> there any reason not to use /* */ here?

Documentation/process/license-rules.rst states:

2. Style:

   The SPDX license identifier is added in form of a comment.  The comment
   style depends on the file type::

      C source: // SPDX-License-Identifier: <SPDX License Expression>
      C header: /* SPDX-License-Identifier: <SPDX License Expression> */
      ASM:      /* SPDX-License-Identifier: <SPDX License Expression> */
      scripts:  # SPDX-License-Identifier: <SPDX License Expression>
      .rst:     .. SPDX-License-Identifier: <SPDX License Expression>
      .dts{i}:  // SPDX-License-Identifier: <SPDX License Expression>

Read more in that file for reasons. If there are none, I personally
think the reason is that "Linus said so". Or something like that?

Cheers,
Peter
