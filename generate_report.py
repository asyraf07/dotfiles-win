import glob
import os
import xlsxwriter


dirname = os.path.dirname(os.path.realpath(__file__))
report_path = os.path.abspath(dirname + "/daily-report/*")
result_path = os.path.abspath(dirname + "/Asyraf Tasks.xlsx")

filepaths = glob.glob(report_path)


def sort_file(el):
    filename = os.path.basename(el)
    value = filename.replace("Daily report ", "").replace(".txt", "").split("_")
    day = int(value[0])
    month = int(value[1])
    year = int(value[2])
    return day + (month * 100) + (year * 100)


filepaths.sort(reverse=False, key=sort_file)


def pretty_print(arr):
    for el in arr:
        filename = os.path.basename(el)
        print(filename.replace("Daily report ", "").replace(".txt", "").split("_"))


def get_date(path):
    filename = os.path.basename(path)
    value = filename.replace("Daily report ", "").replace(".txt", "").split("_")
    day = value[0]
    month = value[1]
    year = value[2]
    return day + "/" + month + "/" + year


workbook = xlsxwriter.Workbook(result_path)
worksheet = workbook.add_worksheet()

border = workbook.add_format({"border": 1, "border_color": "black"})

worksheet.write(0, 0, "Date", border)
worksheet.write(0, 1, "Tasks", border)
row = 1
for path in filepaths:
    with open(path) as file:
        file.readline()
        lines = file.readlines()

        # Date
        if len(lines) > 1:
            worksheet.merge_range(
                row,
                0,
                row + len(lines) - 1,
                0,
                get_date(path),
                workbook.add_format(
                    {
                        "align": "center",
                        "valign": "vcenter",
                        "border": 1,
                        "border_color": "black",
                    }
                ),
            )
        else:
            worksheet.write(row, 0, get_date(path), border)

        # Activities
        for line in lines:
            worksheet.write(row, 1, line[line.find(". ") + 2 :], border)
            row += 1


worksheet.autofit()

workbook.close()
