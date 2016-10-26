From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] I2C Designware Core Supports SMBUS BLOCK
Date: Wed, 26 Oct 2016 12:30:34 +0300
Message-ID: <20161026093034.GO1476@lahna.fi.intel.com>
References: <1477370113-15145-1-git-send-email-tnhuynh@apm.com>
 <20161025115025.GI1476@lahna.fi.intel.com>
 <CANQ9TuB5BbR40TEndGqQ6ABDSUsCOGjEhXSvmD78jtuqGRpXvg@mail.gmail.com>
 <20161026081600.GM1476@lahna.fi.intel.com>
 <CANQ9TuAgW7ubyKq1RAiw+s=ooF4G99_MMWnG1a0bV3DxKa+UPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:19923 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758270AbcJZJar (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 26 Oct 2016 05:30:47 -0400
Content-Disposition: inline
In-Reply-To: <CANQ9TuAgW7ubyKq1RAiw+s=ooF4G99_MMWnG1a0bV3DxKa+UPw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches <patches@apm.com>

On Wed, Oct 26, 2016 at 04:20:57PM +0700, Tin Huynh wrote:
>    We need to set stop bit if three conditions are true :  The latest
>    bytes , the latest msg_write_ids and after receiving the buffer length.
>    If we use i2c_dw_xfer_need_stop , arguments of function are complex.

OK, so you would need to pass dev and buf_len to that.

>    Can i use i2c_dw_xfer_receive_length() function  ?
>    Thank  you and best regards
>    Tin
>                       if (dev->msg_write_idx == dev->msgs_num - 1 &&
>    -                           buf_len == 1)
>    +                           buf_len == 1 && !(flags & I2C_M_RECV_LEN))
>                                    cmd |= BIT(9);

Maybe it is better if you just do it like the above then.
