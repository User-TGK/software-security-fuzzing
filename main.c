#include <stdio.h>
#include <stdlib.h>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image/stb_image.h"

int main(int argc, char **argv)
{
    FILE *f;
    char *buf = NULL;
    long siz_buf;

    if (argc < 2)
    {
        fprintf(stderr, "No input file submitted\n");
        goto err;
    }

    f = fopen(argv[1], "rb");
    if (f == NULL)
    {
        fprintf(stderr, "Error opening input file %s\n", argv[1]);
        goto err;
    }

    fseek(f, 0, SEEK_END);

    siz_buf = ftell(f);
    rewind(f);

    if (siz_buf < 1)
        goto err;

    buf = (char *)malloc((size_t)siz_buf);
    if (buf == NULL)
    {
        fprintf(stderr, "malloc() failed\n");
        goto err;
    }

    if (fread(buf, (size_t)siz_buf, 1, f) != 1)
    {
        fprintf(stderr, "fread() failed\n");
        goto err;
    }

    const uint8_t *data = (uint8_t *)buf;
    size_t size = siz_buf;
    int x, y, channels;

    if (!stbi_info_from_memory(data, size, &x, &y, &channels))
    {
        goto err;
    }

    if (y && x > (80000000 / 4) / y)
        return 0;

    unsigned char *img = stbi_load_from_memory(data, size, &x, &y, &channels, 4);

    free(img);

err:
    free(buf);

    return 0;
}
