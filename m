From: Laszlo Papp <lpapp@kde.org>
Subject: Re: [PATCH v2 1/2] Create eeprom_dev hardware class for EEPROM devices
Date: Fri, 24 Jan 2014 18:42:51 +0000
Message-ID: <CAOMwXhMfd8uw8n2Oa_BKW8UGzrUttD1L3=ATUGyDJMFy3kPUjQ@mail.gmail.com>
References: <1390504562-20333-1-git-send-email-curt@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390504562-20333-1-git-send-email-curt@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Curt Brune <curt@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Thomas De Schampheleire <patrickdepinguin@gmail.com>, gregkh@linuxfoundation.org, Shrijeet Mukherjee <shm@cumulusnetworks.com>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

> Note: The class cannot be called 'eeprom' as that is the name of the
> I/O file created by the driver.  The class name appears as a
> sub-directory within the main device directory.  Hence the class name
> 'eeprom_dev'.

I am not sure I follow the reasoning here, but it is possibly because
I lack some knowledge. Could you please describe bad thing would
happen if "/sys/class/eeprom/eeprom0/label" would be used as opposed
to "/sys/class/eeprom_dev/eeprom0/label"?
