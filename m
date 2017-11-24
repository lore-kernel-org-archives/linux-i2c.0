From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 5/7] eeprom: at24: add regmap-based read function
Date: Fri, 24 Nov 2017 19:01:28 +0000
Message-ID: <74f8d698-4e52-7b03-7b60-770e5a954491@linaro.org>
References: <0448eec2-7dfb-ca79-d03a-d5b7fcb5d76c@gmail.com>
 <011081f7-f2af-0e78-f21b-c40493d63a70@gmail.com>
 <CAMRc=McNp=NWeGxZZfz1Xq+sxx+-X1OAFsyoEPrFTn3vaH77mQ@mail.gmail.com>
 <245157a7-bd46-9788-86e9-7058cc4c667b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36380 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdKXTBc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Nov 2017 14:01:32 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so24501046wmr.1
        for <linux-i2c@vger.kernel.org>; Fri, 24 Nov 2017 11:01:31 -0800 (PST)
In-Reply-To: <245157a7-bd46-9788-86e9-7058cc4c667b@gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>



On 23/11/17 21:31, Heiner Kallweit wrote:
> To build an opinion on |= vs. += I checked the code in more detail plus
> some datasheets, what lead to quite some question marks ..
> 
> Major issue is that offset and size in at24_read/write are not checked
> currently. So we completely rely on the calling subsystem (nvmem).
> The nvmem sysfs interface does such checking. However nvmem_device_read
> does not. So maybe the nvmem core should be changed to do checking in
> all cases. I add Srinivas as nvmem maintainer to the conversation
> to hear his opinion.w.r.t nvmem I can see these sanity check are missing form read/writes.

we should probably add the check when we add the cell itself something 
like this below should do the job..

I will send a proper patch after testing..
------------------------>cut<--------------------------
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d12e5de78e70..8ae865765754 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -320,11 +320,26 @@ static void nvmem_device_remove_all_cells(const 
struct nvmem_device *nvmem)
         }
  }

-static void nvmem_cell_add(struct nvmem_cell *cell)
+static int nvmem_cell_add(struct nvmem_cell *cell)
  {
+       struct nvmem_device *nvmem = cell->nvmem;
+
+       if (cell->offset >= nvmem->size)
+               return -EINVAL;
+
+       if (cell->bytes < nvmem->word_size)
+               return -EINVAL;
+
+       if (cell->offset + cell->bytes > nvmem->size)
+               cell->bytes = nvmem->size - cell->offset;
+
+       cell->bytes = round_down(cell->bytes, nvmem->word_size);
+
         mutex_lock(&nvmem_cells_mutex);
         list_add_tail(&cell->node, &nvmem_cells);
         mutex_unlock(&nvmem_cells_mutex);
+
+       return 0;
  }

  static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
@@ -377,7 +392,11 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
                         goto err;
                 }

-               nvmem_cell_add(cells[i]);
+               rval = nvmem_cell_add(cells[i]);
+               if (rval) {
+                       kfree(cells[i]);
+                       goto err;
+               }
         }

         nvmem->ncells = cfg->ncells;
@@ -830,7 +849,9 @@ struct nvmem_cell *of_nvmem_cell_get(struct 
device_node *np,
                 goto err_sanity;
         }

-       nvmem_cell_add(cell);
+       rval = nvmem_cell_add(cell);
+       if (rval)
+               goto err_sanity;

         return cell;
------------------------>cut<--------------------------
